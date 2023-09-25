import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/image_service_controller.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'controllers/string_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_class/FirebaseControllers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final _formKey = GlobalKey<FormState>();
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController = TextEditingController();

    void initState() {
      super.initState();
      emailTextController.addListener(() {
        
      });
      passwordTextController.addListener(() {
        
      });
    }

    void dispose() {
      emailTextController.dispose();
      passwordTextController.dispose();
      super.dispose();
    }

    moveToHome(BuildContext context) {
      if(_formKey.currentState!.validate()){
        Navigator.pushNamed(context, '/');  
      }
      
    }



  @override
  Widget build(BuildContext context) {

    appBarStringController("Login Page.");

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
                "Login page.",
                textScaleFactor: 1.5,  
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ), 

              SizedBoxWidget(),

                TextFormFieldWidget(
                  "Email",
                  "Email",
                  OutlineInputBorder(),
                  emailTextController,
                ),

                SizedBox(height: 10),

                TextFormFieldWidget(
                  "Password",
                  "Password",
                  OutlineInputBorder(),
                  passwordTextController,
                  obscureText: true,
                ),

                SizedBox(
                  height: 20.0,
                ),

                ElevatedButton(
                  child: Text("Login"),
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () async => {
                    RegisterUserDetails.loginUserWithEmailAndPassword(emailTextController.text, passwordTextController.text),
                    AutoLoginFunction.persistStateLogin(context), 

                    await executeAsAMainFunction(),

                    Navigator.pushNamedAndRemoveUntil(context, "/", (route)=>false),
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