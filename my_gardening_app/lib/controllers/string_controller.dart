import '/firebase_class/FirebaseControllers.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var AppBarStringController = "Default Appbar";
var RedirectionTextStringController = "Login first to access required information";

var Image1StringController = "default image";
var Image2StringController = "default image";
var Image3StringController = "default image";
var Image4StringController = "default image";
var TitleComplaintStringController = "default title";
var ComplaintStringController = "default value";

final backgroundHomeColorForGreenTheme = Color.fromARGB(234, 39, 252, 106);

String additionalInfoStringController = "";
String completeUidStringController = "";

String defaultImageStringForHome = "https://asia.olympus-imaging.com/content/000107506.jpg";
const String errorURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png";
String newsFetchUrl = "https://www.fibre2fashion.com/news/wool-news";

List<String> fetchComplaintDataOnId = ["", "", "", "", "", "", ""];

String appBarStringController(String sample) {
  AppBarStringController = sample;
  return AppBarStringController;
}

String redirectionTextStringController(String sample) {
  RedirectionTextStringController = sample;
  return RedirectionTextStringController;
}

Future<void> getComplaintData(String userService) async {
  fetchComplaintDataOnId = await GetDataFromCloudFirestore.getComplaintData(userService);
  utilFunctions.toastMessageService("$fetchComplaintDataOnId");
}

String image1StringController(String? sample) {
  if(sample != null && sample != ""){
    Image1StringController = sample;
  }

  else{
    Image1StringController = errorURL;
  }

  return Image1StringController;
}

String image2StringController(String? sample) {
  if(sample != null && sample != "") {
    Image2StringController = sample;
  }

  else{
    Image2StringController = errorURL;
  }
  
  return Image2StringController;
}

String image3StringController(String? sample) {
  if(sample != null && sample != ""){
    Image3StringController = sample;
  }
  else{
    Image3StringController = errorURL;
  }
  
  return Image3StringController;
}

String image4StringController(String? sample) {
  if(sample != null && sample != ""){
    Image4StringController = sample;
  }
  
  else{
    Image4StringController = errorURL;
  }
  return Image4StringController;
}

String titleComplaintStringController(String sample) {
  TitleComplaintStringController = sample;
  return TitleComplaintStringController;
}

String complaintStringController(String sample) {
  ComplaintStringController = sample;
  return ComplaintStringController;
}

String additionalInfoStringControllerFunction(String userId) {
  additionalInfoStringController = userId;
  return additionalInfoStringController;
}

String completeUidStringControllerFunction(String userId) {
  completeUidStringController = userId;
  return completeUidStringController;
}