import pandas as pd
import numpy as np
from copy import deepcopy as dc
from sklearn.preprocessing import MinMaxScaler
import torch
from loader import TimeSeriesDataset
from torch.utils.data import DataLoader
import torch.nn as nn
from model import LSTM
import matplotlib.pyplot as plt

def inverse(data):
    dummies=np.zeros((data.shape[0],lookback+1))
    dummies[:,0]=data.flatten()
    dummies=scaler.inverse_transform(dummies)
    predictions=dc(dummies[:,0])
    return predictions

def train_one_epoch(train_loader,model,epoch,loss_function,optimizer):
    model.train(True)
    print(f'Epoch: {epoch + 1}')
    running_loss = 0.0
    
    for batch_index, batch in enumerate(train_loader):
        x_batch, y_batch = batch[0].to(device), batch[1].to(device)
        
        output = model(x_batch)
        loss = loss_function(output, y_batch)
        running_loss += loss.item()
        
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
    avg_loss_across_batches = running_loss / len(train_loader)
    print('Train Loss: {0:.3f}'.format(avg_loss_across_batches))
    
def validate_one_epoch(test_loader,model,epoch,loss_function):
    model.train(False)
    running_loss = 0.0
    
    for batch_index, batch in enumerate(test_loader):
        x_batch, y_batch = batch[0].to(device), batch[1].to(device)
        
        with torch.no_grad():
            output = model(x_batch)
            loss = loss_function(output, y_batch)
            running_loss += loss.item()

    avg_loss_across_batches = running_loss / len(test_loader)
    
    print('Val Loss: {0:.3f}'.format(avg_loss_across_batches))

def train():
    split_index=int(len(X)*0.85)
    X_train=X[:split_index]
    X_test=X[split_index:]
    y_train=y[:split_index]
    y_test=y[split_index:]
    
    X_train = X_train.reshape((-1, lookback, 1))
    X_test = X_test.reshape((-1, lookback, 1))
    y_train = y_train.reshape((-1, 1))
    y_test = y_test.reshape((-1, 1))
    
    X_train=torch.tensor(X_train).float()
    y_train=torch.tensor(y_train).float()
    X_test=torch.tensor(X_test).float()
    y_test=torch.tensor(y_test).float()
    
    train_dataset=TimeSeriesDataset(X_train,y_train)
    test_dataset=TimeSeriesDataset(X_test,y_test)
    model=LSTM(1,8,2).to(device)
    
    train_loader=DataLoader(train_dataset,batch_size=8,shuffle=True)
    test_loader=DataLoader(test_dataset,batch_size=1,shuffle=False)
    learning_rate = 1e-3
    num_epochs = 50
    loss_function=nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

    for epoch in range(num_epochs):
        train_one_epoch(train_loader,model,epoch,loss_function,optimizer)
        validate_one_epoch(test_loader,model,epoch,loss_function)
        
    with torch.no_grad():
        train_predictions = model(X_train.to(device)).to('cpu').numpy()
        test_predictions = model(X_test.to(device)).detach().cpu().numpy().flatten()
        
    filepath="TimeSeriesLSTM.pth"        
    torch.save(model.state_dict(),filepath)
    
    train_predictions=inverse(train_predictions)
    y_train=inverse(y_train)
    test_predictions=inverse(test_predictions)
    y_test=inverse(y_test)
    
    plt.plot(y_train, label='Actual')
    plt.plot(train_predictions, label='Predicted')
    plt.xlabel('Month')
    plt.ylabel('Price')
    plt.legend()
    plt.show()
    plt.savefig('Fine Wool Training')
    
    plt.plot(y_test, label='Actual')
    plt.plot(test_predictions, label='Predicted')
    plt.xlabel('Day')
    plt.ylabel('Close')
    plt.legend()
    plt.show()
    plt.savefig('Fine Wool Testing')
    
if __name__ == '__main__':
    df=pd.read_csv('Wool_Prices.csv')

    def prepare_dataframe_for_lstm(df, n_steps):
        df = dc(df)
        
        df.set_index('Date', inplace=True)
        
        for i in range(1, n_steps+1):
            df[f'Price(t-{i})'] = df['Price(Rs/Kg)'].shift(i)
            
        df.dropna(inplace=True)
        
        return df

    lookback=3
    df=prepare_dataframe_for_lstm(df,lookback)
    df=df.to_numpy()
    scaler = MinMaxScaler(feature_range=(-1, 1))
    df = scaler.fit_transform(df)
    X=df[:,1:]
    y=df[:,0]
    X=dc(np.flip(X,axis=1))
    device=torch.device('cuda')
    train()