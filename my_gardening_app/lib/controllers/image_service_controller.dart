import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> publicUserData = ["", "", "", "", "", ""];

Future<void> getUserData(String userService) async {
  publicUserData = await GetDataFromCloudFirestore.getRegistrationData(userService);
  //utilFunctions.toastMessageService("$publicUserData");
}

Future<void> executeAsAMainFunction() async {
  if(FirebaseAuth.instance.currentUser != null){
    await getUserData(FirebaseAuth.instance.currentUser!.uid.toString());
  }
}