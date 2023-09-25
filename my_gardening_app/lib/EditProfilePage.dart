import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/image_service_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

    static late String imageContainer = publicUserData[5];
    static late List<String> userData = publicUserData;

    final TextEditingController nameTextController = TextEditingController(text: userData[0]);
    final TextEditingController emailTextController = TextEditingController(text: userData[3]);
    final TextEditingController phoneTextController = TextEditingController(text: userData[1]);
    final TextEditingController addressTextController = TextEditingController(text: userData[2]);

    @override
    void initState() {
      super.initState();
      nameTextController.addListener(() {
        
      });
      emailTextController.addListener(() {
        
      });
      phoneTextController.addListener(() {
        
      });
      addressTextController.addListener(() {
        
      });
      //TODO ADD SOMETHING IN THE FUTURE WHICH REQUIRES A TEXT CONTROLLER TO LISTEN.
    }

    @override
    void dispose() {
      nameTextController.dispose();
      emailTextController.dispose();
      phoneTextController.dispose();
      addressTextController.dispose();

      super.dispose();
    }

    void  setProfileImage() async {
      String imageUrl = await UploadImageInFirebaseStorage.uploadProfileImage("GALLERY");
      if(imageUrl != "NO"){
        setState(() {
          imageContainer = imageUrl;
        });
        
      }
      else{
        setState(() {
          imageContainer = "https://asia.olympus-imaging.com/content/000107506.jpg";
        });
        
        utilFunctions.toastMessageService("Could not load image. Please try again later.");
      }
    }

  @override
  Widget build(BuildContext context) {

    appBarStringController("Edit your profile.");
    utilFunctions.getCurrentUserId(context);

    imageContainer = publicUserData[5];
    userData = publicUserData;

    return Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),
      body: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal:16.0),
        child: SingleChildScrollView(
            child: Column(
              children: [

              Text(
                "Welcome to the edit profile page.", 
                textScaleFactor: 1.5, 
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),

              SizedBoxWidget5(),

              Center(
                child: Text(
                  "Edit your profile here.",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),
              
              SizedBoxWidget(),
              SizedBoxWidget(),

              Center(
                child: Text(
                  "Your Profile Picture.",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),

              SizedBoxWidget(),

              Center(
                  child: InkWell(
                    
                    onTap: () async {
                      setProfileImage();
                    },

                    child: CircleAvatar (  
                      backgroundImage: Image.network(imageContainer).image, 
                      radius: 100,
                    ),
                  ),
              ),

              SizedBoxWidget(),

              TextFormFieldWidget(userData[0], "Name", OutlineInputBorder(), nameTextController),

              SizedBoxWidget(),

              TextFormFieldWidget(userData[1], "Phone", OutlineInputBorder(), phoneTextController),

              SizedBoxWidget(),

              TextFormFieldWidget(userData[2], "Address", OutlineInputBorder(), addressTextController),

              SizedBoxWidget(),
  
              TextFormFieldWidget(userData[3], "Email", OutlineInputBorder(), emailTextController),

                SizedBox(
                  height: 20.0,
                ),

                ElevatedButton(
                  child: Text("Update"),
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () async {
                    if(FirebaseAuth.instance.currentUser != null) {
                      await UpdateDataInCloudFirestore.updateRegistrationData(FirebaseAuth.instance.currentUser!.uid, nameTextController.text, phoneTextController.text, addressTextController.text, emailTextController.text, publicUserData[4], imageContainer);
                    }

                    else{
                      utilFunctions.toastMessageService("Login to edit the profile.");
                    }
                    
                  }
                )

              ],
            ),
        ),
      ),
        
      );
  }
}
