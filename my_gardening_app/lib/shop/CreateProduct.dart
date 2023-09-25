import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'package:my_gardening_app/shop/util_controls/string_resource.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'shop_controller/ShopFirebaseController.dart';


class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  int counter = 0;
  final TextEditingController nameTextController = TextEditingController(text: "Name");
  final TextEditingController shortDescTextController = TextEditingController(text: "Short Description");
  final TextEditingController longDescTextController = TextEditingController(text: "Long Description");
  final TextEditingController priceTextController = TextEditingController(text: "Price");
  final TextEditingController quantityTextController = TextEditingController(text: "Quantity");
  
  String category = "";
  String name = "";
  String shortDesc = "";
  String longDesc = "";
  String price = "";
  int quantity = 0;
  String imageContainer = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";

  List<String> listOfPets = [bulbsInShopCategory, potsInShopCategory, seedsInShopCategory, toolsInShopCategory, plantsInShopCategory, pebblesInShopCategory, furnitureInShopCategory, accessoriesInShopCategory, fertilizersInShopCategory, gardeningSuppliesInShopCategory];
  String dropdownValue = bulbsInShopCategory;

  List<String> listOfComplaintImages = [];
  void incrementCounter(String value) {
    setState(() {
      listOfComplaintImages.add(value);
      counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    nameTextController.addListener(() {
      
    });

    shortDescTextController.addListener(() {
      
    });

    longDescTextController.addListener(() {
      
    });

    priceTextController.addListener(() {
      
    });

    quantityTextController.addListener(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {

    appBarStringController("Create a new product");
    utilFunctions.getCurrentUserId(context);


    return Scaffold(
      
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),

      body: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
        child: Column(
          children: [

            Text(
                "Create a new product.",
                textScaleFactor: 1.5,  
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),

              SizedBoxWidget(),
              SizedBoxWidget(),

              DropdownButtonFormField(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              decoration: InputDecoration(
                labelText: "Select your category",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: listOfPets.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),

            SizedBoxWidget(),

            TextFormFieldWidget("Enter the name of the product", "Name", OutlineInputBorder(), nameTextController),

            SizedBoxWidget(),

            TextFormFieldWidget("Enter a short description of the product", "Short", OutlineInputBorder(), shortDescTextController),

            SizedBoxWidget(),

            TextFormFieldWidget("Enter a long description of the product", "Long", OutlineInputBorder(), longDescTextController),

            SizedBoxWidget(),

            TextFormFieldWidget("Price", "Price", OutlineInputBorder(), priceTextController),

            SizedBoxWidget(),

            TextFormFieldWidget("Quantity(Stocks of the product)", "Quantity", OutlineInputBorder(), quantityTextController),

            SizedBoxWidget(),

            ElevatedButton(
              child: Text("Upload Images(Max. 4 images)"),
              onPressed: () async {
                final imageUrl = await UploadImageInFirebaseStorage.uploadComplaintImage("GALLERY", complaintStringIdentifier: "ProductImages");
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
              child: Text("Create"),
              onPressed: () async {
                String imageContainer2 = "";
                String imageContainer3 = ""; 
                String imageContainer4 = "";

                if(FirebaseAuth.instance.currentUser != null){
                  imageContainer = listOfComplaintImages[0];
                  imageContainer2 = listOfComplaintImages[1];
                  imageContainer3 = listOfComplaintImages[2];
                  imageContainer4 = listOfComplaintImages[3];

                  await ProductFetchThroughFirebase.addProductData(dropdownValue, name, shortDesc, longDesc, quantity, price, imageContainer, imageContainer2, imageContainer3, imageContainer4);
                  utilFunctions.toastMessageService("New product created under the category $dropdownValue");
                }

                else{
                  utilFunctions.toastMessageService("Log in first through administrator account.");
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