import 'package:flutter/material.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/controllers/image_service_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageContainerBox extends StatefulWidget {
  const ImageContainerBox({super.key});

  @override
  State<ImageContainerBox> createState() => _ImageContainerBoxState();
}

class _ImageContainerBoxState extends State<ImageContainerBox> {
  
  static List<String> profilePublic = publicUserData;
  static String completeUidStringForCheckValidation = completeUidStringController;
  static String phoneNumber = "";
  static String emailUser = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Complaint data",

          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),

          textScaleFactor: 1.3,

        ),
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, "/complaintdata", (route) => false);
          },
          child: Icon(Icons.arrow_back_ios ,color: Colors.black),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Complaint Data : ",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily
                  ),

                  textScaleFactor: 1.5,
                ),
              ),

              SizedBoxWidget(),

              Center(
                child: Text("Title: $TitleComplaintStringController", style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily), textScaleFactor: 1.2),
              ),

              SizedBoxWidget(),

              Center(
                child: Text("Complaint: $ComplaintStringController", style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily), textScaleFactor: 1.2),
              ),

              SizedBoxWidget(),

              Center(
                child : Image.network(Image1StringController),
              ),

              SizedBoxWidget(),

              Center(
                child : Image.network(Image2StringController),
              ),

              SizedBoxWidget(),

              Center(
                child : Image.network(Image3StringController),
              ),

              SizedBoxWidget(),

              Center(
                child : Image.network(Image4StringController),
              ),

              SizedBoxWidget(),

              Center(
                child : Text(
                  "Name : ${profilePublic[0]}",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                  textScaleFactor: 1.3,
                  ),
              ),

              SizedBoxWidget5(),

              Center(
                child : InkWell(
                  child: Text(
                  "Phone : ${profilePublic[1]}",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    color: Colors.blue,
                  ),
                  textScaleFactor: 1.3,
                  
                  ),

                  onTap: () async {
                    phoneNumber = "tel:${profilePublic[1]}";
                    if(await canLaunchUrl(Uri.parse(phoneNumber))){
                      await launchUrl(Uri.parse(phoneNumber));
                    }

                    else{
                      utilFunctions.toastMessageService("Could not open phone.");
                    }

                  },
                ),
                
              ),

              SizedBoxWidget5(),
              
              Center(
                child : Text(
                  "Address : ${profilePublic[2]}",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                  textScaleFactor: 1.3,
                  ),
              ),

              SizedBoxWidget5(),

              Center(
                child : InkWell(
                 child: Text(
                  "Email : ${profilePublic[3]}",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    color: Colors.blue,
                  ),
                  textScaleFactor: 1.3,
                  ),

                  onTap: () async {
                    emailUser = profilePublic[3];
              
                    Uri emailParams = Uri(scheme: 'mailto', path: emailUser);

                    if(await canLaunchUrl(emailParams)){
                      await launchUrl(emailParams);
                    }

                    else{
                      utilFunctions.toastMessageService("Could not open email.");
                    }
                  },
                ),
                 
              ),

              SizedBoxWidget(),

              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await UpdateDataInCloudFirestore.updateCheckValidationStatus(completeUidStringForCheckValidation);
                    utilFunctions.toastMessageService("Your complaint is now marked as solved.");
                    if(!context.mounted) return;
                    Navigator.pushNamedAndRemoveUntil(context, "/complaintdata", (route) => false);
                  },

                  child: Text("Mark it as solved."),
                ),
              ),
            ],
          ),
        ),
      ),  
    );
  }
}