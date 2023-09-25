import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  int counter = 0;
  
  static String title = "";
  static String complaint = "";
  static String imageContainer = "";

  List<String> listOfComplaintImages = [];
  void incrementCounter(String value) {
    setState(() {
      listOfComplaintImages.add(value);
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    appBarStringController("File a complaint.");
    utilFunctions.getCurrentUserId(context);


    return Scaffold(
      
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),

      body: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
        child: Column(
          children: [

            Text(
                "File a complaint.",
                textScaleFactor: 1.5,  
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),


            TextFormField(
              decoration:InputDecoration(
                hintText: "Enter the title of the complaint",
                labelText: "Enter the title.",
              ),

              onChanged: (value) => {
                if(value != ""){
                    title = value,
                }
              },
            ),

            SizedBoxWidget(),

            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Enter the complaint.",
              ),

              onChanged: (value)=>{
                if(value != ""){
                  complaint = value,
                }
                
              },
            ),

            SizedBoxWidget(),

            ElevatedButton(
              child: Text("Upload Images(Max. 4 images)"),
              onPressed: () async {
                final imageUrl = await UploadImageInFirebaseStorage.uploadComplaintImage("GALLERY");
                if(imageUrl != "NO" && counter <= 4) {
                  imageContainer = imageUrl;
                  incrementCounter(imageContainer);
                }

                else{
                  utilFunctions.toastMessageService("Cannot post more images.");
                  imageContainer = "NoImage";
                }
                //Navigator.pushNamed(context, "/");
              }
            ),

            SizedBoxWidget(),

            ElevatedButton(
              child: Text("Submit Complaint."),
              onPressed: () async {
                String imageContainer2 = "";
                String imageContainer3 = ""; 
                String imageContainer4 = "";

                if(FirebaseAuth.instance.currentUser != null){
                  imageContainer = listOfComplaintImages[0];
                  imageContainer2 = listOfComplaintImages[1];
                  imageContainer3 = listOfComplaintImages[2];
                  imageContainer4 = listOfComplaintImages[3];

                  String finalIdentifier = FirebaseAuth.instance.currentUser!.uid.toString() + " ${DateTime.now()}";

                  await AddDataToCloudFirestore.addComplaintData(finalIdentifier, title, complaint, imageContainer, imageContainer2, imageContainer3, imageContainer4);
                }

                else{
                  utilFunctions.toastMessageService("Log in to file a complaint.");
                }
                
                //Navigator.pushNamed(context, "/");
              }
            ),
          ],
        ),
      ),
      ),
      
      
    );
  }
}