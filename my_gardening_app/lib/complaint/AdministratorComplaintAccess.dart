import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/image_service_controller.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import '../widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/list/item_data_class.dart';
import '../widgets/list/list_item.dart';

class AuthorizedComplaintAccess extends StatefulWidget {
  const AuthorizedComplaintAccess({super.key});

  @override
  State<AuthorizedComplaintAccess> createState() => _AuthorizedComplaintAccessState();
}

class _AuthorizedComplaintAccessState extends State<AuthorizedComplaintAccess> {
  static String uidLabel = "";
  static String title = "";
  static String complaint = "";
  static String image1 = "";
  static String image2 = "";
  static String image3 = "";
  static String image4 = "";
  static String transferUserId = "";
  static String completeUidString = "";

  static List<Item> dataStringList = [];
  static List<Item> allDataStringList = [];

  static String complaintText = "";

  void updateData(int i, String dupTitle, String dupComplaint, String dupImage1, String dupImage2, String dupImage3, String dupImage4, String dupUserId, String dupCompleteUid) {
    setState(() {
      complaintText += "${i+1}.) Title : $dupTitle\n\n";
      complaintText += "Complaint : $dupComplaint\n\n";
      complaintText += "Image1 : $dupImage1\n\n";
      complaintText += "Image2 : $dupImage2\n\n";
      complaintText += "Image3 : $dupImage3\n\n";
      complaintText += "Image4 : $dupImage4\n\n";
      complaintText += "\n\n\n";

      Item tempItem = Item(title: dupTitle, complaint: dupComplaint, image1: dupImage1, image2: dupImage2, image3: dupImage3, image4: dupImage4, userUid: dupUserId, completeUid: dupCompleteUid);
      if(!dataStringList.contains(tempItem)){
        dataStringList.add(tempItem);
      }
      
    });
  }

  void transferUserData(String uid) {
    setState(() {
      additionalInfoStringControllerFunction(uid);  
    });
    
  }

  void transferCompleteUid(String uid) {
    setState(() {
      completeUidStringControllerFunction(uid);
    });
  }

  void setEmptyState() {
    setState(() {
      dataStringList = [];  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    appBarStringController("Access a Particular Complaint.");


    return Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),
      body: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Access Complaint Data",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
              textScaleFactor: 1.5,
            ),

            SizedBoxWidget(),

            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter email to access complaint data.",
                labelText: "Email",
              ),

              onChanged: (value) => {
                uidLabel = value,
              },
            ),

            SizedBoxWidget(),

            Column(
              children: [
                Center(
                    child: ElevatedButton(
                    
                      child: Text("Click here to fetch complaint."),

                      onPressed: () async {
                        setEmptyState();
                        String profileDataConatinerForComplaint = await FetchComplaintCollectionData.getUidFromEmail(uidLabel);
                        List<dynamic> complaintDataContainer = await FetchComplaintCollectionData.getComplaintFromCollectionData(profileDataConatinerForComplaint);

                        await getUserData(profileDataConatinerForComplaint);

                        for(int i=0; i<complaintDataContainer.length; i++) {
                          title = complaintDataContainer[i]['title'];
                          complaint = complaintDataContainer[i]['complaint'];
                          image1 = complaintDataContainer[i]['image1'];
                          image2 = complaintDataContainer[i]['image2'];
                          image3 = complaintDataContainer[i]['image3'];
                          image4 = complaintDataContainer[i]['image4'];
                          transferUserId = complaintDataContainer[i]['userId'].toString().split(" ")[0];
                          completeUidString = complaintDataContainer[i]['userId'].toString();
                          updateData(i, title, complaint, image1, image2, image3, image4, transferUserId, completeUidString);
                        }
                    }, 
                    
                  ),
                ),

                SizedBoxWidget(),

                Center(
                  child: ElevatedButton(
                    child: Text("Fetch all complaints."),
                    onPressed: () async {
                      setEmptyState();
                      List<dynamic> allDataContainerComplaint = await FetchComplaintCollectionData.getAllDataFromCollection();
                      for(int i = 0; i < allDataContainerComplaint.length; i++) {
                          title = allDataContainerComplaint[i]['title'];
                          complaint = allDataContainerComplaint[i]['complaint'];
                          image1 = allDataContainerComplaint[i]['image1'];
                          image2 = allDataContainerComplaint[i]['image2'];
                          image3 = allDataContainerComplaint[i]['image3'];
                          image4 = allDataContainerComplaint[i]['image4'];
                          transferUserId = allDataContainerComplaint[i]['userId'].toString().split(" ")[0];
                          completeUidString = allDataContainerComplaint[i]['userId'].toString();
                          updateData(i, title, complaint, image1, image2, image3, image4, transferUserId, completeUidString);
                          transferUserData(transferUserId);
                          transferCompleteUid(completeUidString);
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBoxWidget(),

            // Center(
            //   child: Text(
            //     complaintText,
            //   ),
            // ),

            SingleChildScrollView(
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataStringList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if(dataStringList.length == 0){
                  return Text("Nothing to display!!");
                }

                else{
                  return ItemWidget(
                    item: dataStringList[index],
                  );
                }
                
              }
            )
            ),
            
            
          ],
        ),
      ),
      ),

    );
  }
}