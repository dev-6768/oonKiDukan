import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'controllers/string_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static String imageContainer = "https://asia.olympus-imaging.com/content/000107506.jpg";
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTextController.addListener(() {
      
    });
    phoneTextController.addListener(() {
      
    });
    addressTextController.addListener(() {
      
    });
    emailTextController.addListener(() {
      
    });
    passwordTextController.addListener(() {
      
    });
    confirmPasswordTextController.addListener(() {
      
    });
  }

  @override
  void dispose() {
    nameTextController.dispose();
    phoneTextController.dispose();
    addressTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();

    super.dispose();
  }

  String name = "";
  String phone = "";
  String email = "";
  String password = "";
  String address = "";

  String? passwordChange = "";

  void setProfileImage() async {
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

    appBarStringController("Register Page.");

    final _formKey = GlobalKey<FormState>();

    moveToHome(BuildContext context) {
      if(_formKey.currentState!.validate()){
        Navigator.pushNamed(context, '/');  
      }
      
    }

    return Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),

      body: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      
        child: SingleChildScrollView(
          child: Form(

            key: _formKey,
            
            child: Column(
            
            children: [

              Text(
                "Welcome to the register page.",
                textScaleFactor: 1.5,
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ), 

              SizedBoxWidget(),

              Center(
                child: Text(
                  "Register with us as a user.",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),

              SizedBoxWidget(),

              Center(
                child: Text(
                  "Your profile picture.",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),
              
              SizedBoxWidget(),
              SizedBoxWidget(),

              Center(
                child: InkWell(
                  onTap: () async {
                    setProfileImage();
                  },

                  child: CircleAvatar(
                    backgroundImage: Image.network(imageContainer).image,
                    radius: 100,
                  ),

                ),
              ),

              SizedBoxWidget(),
              SizedBoxWidget(),
                
              TextFormFieldWidget("Name", "Name", OutlineInputBorder(), nameTextController),

              SizedBoxWidget(),

              TextFormFieldWidget("Phone", "Phone", OutlineInputBorder(), phoneTextController),

              SizedBoxWidget(),

              TextFormFieldWidget("Address", "Address", OutlineInputBorder(), addressTextController),

              SizedBoxWidget(),
              
              TextFormFieldWidget("Email", "Email", OutlineInputBorder(), emailTextController),

              SizedBoxWidget(),
              
              TextFormFieldWidget("Password", "Password", OutlineInputBorder(), passwordTextController),

              SizedBoxWidget(),

              TextFormFieldWidget("Confirm Password", "Confirm Password", OutlineInputBorder(), confirmPasswordTextController),

              SizedBoxWidget(),

              ElevatedButton(
                child: Text("Register"),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: () async =>  {
                  if(nameTextController.text == "" || phoneTextController.text == "" || addressTextController.text == "" || passwordTextController.text == "" || emailTextController.text == "" || imageContainer == "") {
                    utilFunctions.toastMessageService("Please fill all the details correctly."),
                  }

                  else{
                    RegisterUserDetails.registerUserEmailAndPassword(name, phone, address, email, password, imageContainer),
                  }
                  
                  // RegisterUserDetails.loginUserWithEmailAndPassword(email, password),

                  // utilFunctions.getCurrentUserId(context),
                  
                  // AddDataToCloudFirestore.addRegistrationData(currentUserId, name, phone, address, email, password, imageContainer),
                  
                  //print("$email $password onPressed"),
                },
              )

              ],
            ),
          ),


        ),
      ),

    );
  }
}