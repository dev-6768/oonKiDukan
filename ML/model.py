import torch.nn as nn
import torch

device=torch.device('cuda')
class LSTM(nn.Module):
    def __init__(self,input_size,hidden_size,num_stacked_layers):
        super(LSTM,self).__init__()
        self.hidden_size = hidden_size
        self.num_stacked_layers = num_stacked_layers
        self.lstm=nn.LSTM(input_size,hidden_size,num_stacked_layers,batch_first=True)
        self.fc=nn.Linear(self.hidden_size,1)
        
    def forward(self,X):
        batch_size =X.shape[0]
        h0=torch.zeros(self.num_stacked_layers,batch_size,self.hidden_size).to(device)
        c0=torch.zeros(self.num_stacked_layers,batch_size,self.hidden_size).to(device)
        
        out,_=self.lstm(X,(h0,c0))
        out=self.fc(out[:,-1,:])
        return out