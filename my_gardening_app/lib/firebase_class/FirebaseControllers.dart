import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import "package:my_gardening_app/widgets/list/item_data_class.dart";

class AutoLoginFunction {
  static void checkLoginState(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      }

      else{
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      }
    });
  }
  

    static void persistStateLogin(BuildContext context) async {
      final authentication = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.NONE);
      await authentication.setPersistence(Persistence.LOCAL);
    }
}

class AddDataToCloudFirestore {

  static Future<void> addRegistrationData(String userId, String name, String phone, String address, String email, String password, String profileUrl) async {
      final firestore = FirebaseFirestore.instance.collection('UserData');
      await firestore.doc(userId).set({"name":name, "phone":phone, "address":address, "email":email, "password":password, "profile":profileUrl, "userId": userId, "role": "user"});
  }

  static Future<void> addComplaintData(String userId, String title, String complaint, String complaintUrl1, String complaintUrl2, String complaintUrl3, String complaintUrl4, {String checkValidation = "0"}) async {
    try{
      final firestore = FirebaseFirestore.instance.collection('ComplaintData');
      await firestore.doc(userId).set({"title":title, "complaint":complaint, "image1":complaintUrl1, "image2":complaintUrl2, "image3":complaintUrl3, "image4":complaintUrl4, "userId": userId, "checkValidation":checkValidation});  
      utilFunctions.toastMessageService("Successfully uploaded complaint.");
    }

    catch(err) {
      utilFunctions.toastMessageService("Could not upload complaint.");
    }
    
    
  }
}

class GetDataFromCloudFirestore {

  static Future<List<String>> getRegistrationData(String userId) async {
    final firestore = await FirebaseFirestore.instance.collection('UserData').doc(userId).get();
    if(firestore.exists){
      Map<String, dynamic>? registrationData = firestore.data();
      utilFunctions.toastMessageService("Data loaded successfully. $registrationData");
      return [registrationData?["name"], registrationData?["phone"], registrationData?["address"], registrationData?["email"], registrationData?["password"], registrationData?["profile"]];
    }

    else{
      utilFunctions.toastMessageService("Could not fetch data.");
      return ["", "", "", "", "", ""];

    }

  }

  static Future<List<String>> getComplaintData(String userId) async {
    final firestore = await FirebaseFirestore.instance.collection('ComplaintData').doc(userId).get();
    if(firestore.exists){
      Map<String, dynamic>? registrationData = firestore.data();
      return [registrationData?["title"], registrationData?["complaint"], registrationData?["image1"], registrationData?["image2"], registrationData?["image3"], registrationData?["image4"]];
    }

    else{
      utilFunctions.toastMessageService("Could not fetch complaint data.");
      return ["", "", "", "", "", ""];
    }
  }
}

class UpdateDataInCloudFirestore {
  static Future<void> updateRegistrationData(String userId, String name, String phone, String address, String email, String password, String profileUrl) async {
      final firestore = FirebaseFirestore.instance.collection('UserData');
      if(profileUrl != "NO"){
        utilFunctions.toastMessageService("Data updated successfully.");
        await firestore.doc(userId).update({"name":name, "phone":phone, "address":address, "email":email, "profile":profileUrl});
        
      }

      else{
        utilFunctions.toastMessageService("Could not update data in the server. Please try again later.");
      }
      
  }

  static Future<void> updateCheckValidationStatus(String uid) async {
    final firestore = FirebaseFirestore.instance.collection('ComplaintData');
    await firestore.doc(uid).update({"checkValidation": "1"});
  }
}

class RegisterUserDetails {
  static void registerUserEmailAndPassword(String name, String phone, String address, String email, String password, String profileUrl) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      if(FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.signOut();
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

      final firestore = FirebaseFirestore.instance.collection('UserData');

      await firestore.doc(currentUser).set({"name":name, "phone":phone, "address":address, "email":email, "password":password, "profile":profileUrl, "role":"user", "userId":currentUser});
      utilFunctions.toastMessageService("Account created successfully.");
    }

    catch(err) {
      print(err);
      print("$email $password sanidhya");
      utilFunctions.toastMessageService("Could not create account. Please try again later.");
    }
  }


  static void loginUserWithEmailAndPassword(String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      utilFunctions.toastMessageService("Logged in successfully!!");
    }

    catch(err) {
      utilFunctions.toastMessageService("Login failed. Please try again later.");
    }

  }

  static void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    utilFunctions.toastMessageService("Signed out successfully.");
  }

}

class UploadImageInFirebaseStorage {

  static final firebaseStorageInstance = FirebaseStorage.instance;

  static Future<String> uploadComplaintImage(String mode, {String complaintStringIdentifier="ComplaintImages"}) async {
    if(mode == "GALLERY"){
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) {
        utilFunctions.toastMessageService("Failed to load image.");
        return "NO";
      }

      else{
        try{
          var currentTime = DateTime.now();
          final storageReference = firebaseStorageInstance.ref().child("$complaintStringIdentifier:$currentTime");
          final uploadTask = storageReference.putFile(File(image.path));
          print(uploadTask);
          var taskSnapshot = await uploadTask;
          var imageUrl = await taskSnapshot.ref.getDownloadURL();
          utilFunctions.toastMessageService("Image uploaded successfully.");
          return imageUrl;
        }

        catch(err) {
          print(err);
          utilFunctions.toastMessageService("Failed to upload image. Please try again later.");
          return "NO";
        }
      }
    }

    else {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) {
        utilFunctions.toastMessageService("Failed to load image.");
        return "NO";
      }

      else{
        try{
          var currentTime = DateTime.now();
          final storageReference = firebaseStorageInstance.ref().child("$complaintStringIdentifier:$currentTime");
          final uploadTask = storageReference.putFile(File(image.path));
          var taskSnapshot = await uploadTask;
          var imageUrl = await taskSnapshot.ref.getDownloadURL();
          utilFunctions.toastMessageService("Image uploaded successfully.");
          return imageUrl;
        }

        catch(err) {
          utilFunctions.toastMessageService("Failed to upload image. Please try again later.");
          return "NO";
        }
      }
    }
    
  }

  static Future<String> uploadProfileImage(String mode) async {
    if(mode == "GALLERY"){
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) {
        utilFunctions.toastMessageService("Failed to load image.");
        return "NO";
      }

      else{
        try{
          var currentTime = DateTime.now();
          final storageReference = firebaseStorageInstance.ref().child("ProfileImages:$currentTime");
          final uploadTask = storageReference.putFile(File(image.path));
          var taskSnapshot = await uploadTask;
          var imageUrl = await taskSnapshot.ref.getDownloadURL();
          utilFunctions.toastMessageService("Image uploaded successfully.");
          return imageUrl;
        }

        catch(err) {
          print(err);
          utilFunctions.toastMessageService("Failed to upload image. Please try again later.");
          return "NO";
        }
      }
    }

    else {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) {
        utilFunctions.toastMessageService("Failed to load image.");
        return "NO";
      }

      else{
        try{
          var currentTime = DateTime.now();
          final storageReference = firebaseStorageInstance.ref().child("ProfileImages:$currentTime");
          final uploadTask = storageReference.putFile(File(image.path));
          var taskSnapshot = await uploadTask;
          var imageUrl = await taskSnapshot.ref.getDownloadURL();
          //utilFunctions.toastMessageService("Image uploaded successfully. $imageUrl");
          return imageUrl;
        }

        catch(err) {
          utilFunctions.toastMessageService("Failed to upload image. Please try again later.");
          return "NO";
        }
      }
    }
  }
}

class FetchComplaintCollectionData {
  static List<dynamic> dataContainer = [];
  static Future<List<dynamic>> getComplaintFromCollectionData(String value) async {
    final firestore = await FirebaseFirestore.instance.collection("ComplaintData").get();
    for(int i = 0; i < firestore.docs.length ; i++) {
      if(value == firestore.docs[i].data()['userId'].toString().split(" ")[0] && firestore.docs[i].data()['checkValidation'].toString() == "0") {
        dataContainer.add(firestore.docs[i]);
      }
    }
    return dataContainer;
  }

  static List<dynamic> allDataContainer = [];
  static Future<List<dynamic>> getAllDataFromCollection() async {
    final firestore = await FirebaseFirestore.instance.collection("ComplaintData").get();
    for(int i=0; i < firestore.docs.length; i++) {
      if(firestore.docs[i].data()['checkValidation'].toString() == "0"){
        allDataContainer.add(firestore.docs[i]);
      }
      
    }
    return allDataContainer;
  }

  static List<dynamic> profileDataContainer = [];
  static Future<List<dynamic>> getProfileDataForComplaint(String value) async {
    final firestore = await FirebaseFirestore.instance.collection("UserData").get();
    for(int i = 0; i < firestore.docs.length; i++){
      if(value == firestore.docs[i].data()['email'].toString()) {
        profileDataContainer.add(firestore.docs[i]);
        break;
      }
    }

    return profileDataContainer;
  }

  static Future<List<ProductFetch>> getCategoryProductData(String categoryArgs) async {
    List<ProductFetch> productsForASpecificCategory = [];
    final firebase = await FirebaseFirestore.instance.collection("ProductsData").where("category", isEqualTo: categoryArgs).get();
      for(int i=0; i<firebase.docs.length; i++) {
        final element = firebase.docs[i].data();
        final productUniqueId = firebase.docs[i].id.toString();
        utilFunctions.toastMessageService(productUniqueId);
        productsForASpecificCategory.add(ProductFetch(uid: productUniqueId, category: element['category'].toString(), name: element['name'].toString(), shortDesc: element['shortDesc'].toString(), longDesc: element['longDesc'].toString(), price: element['price'].toString(), image1: element['image1'].toString(), image2: element['image2'].toString(), image3: element['image3'].toString(), image4: element['image4'].toString(), quantity: int.parse(element['quantity'].toString()), userId: element['userId'].toString()));
    }

    return productsForASpecificCategory;
  }
  
  static String emailUidContainer = "";
  static Future<String> getUidFromEmail(String email) async {
    final firestore = FirebaseFirestore.instance.collection("UserData");
    await firestore.get().then((snapshot) => snapshot.docs.forEach((doc) {
      if(email == doc.data()['email']){
        emailUidContainer = doc.id.toString().split(" ")[0];
      }
     }));

    return emailUidContainer;
  }



  

}

var currentUserId = "";

class utilFunctions {

  static void getCurrentUserId(BuildContext content) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      
        if(user == null) {
          currentUserId = "";
        }

        else{
          currentUserId = user.uid.toString();
        }
    });
  }

    static void toastMessageService(String msg) {
      Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    static void cancelToastService() {
      Fluttertoast.cancel();
    }
}



