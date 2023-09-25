import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:my_gardening_app/widgets/list/list_item.dart';
import 'shop_controller/ShopFirebaseController.dart';
import 'util_controls/string_resource.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {


  // List<dynamic> productsList = [];

  // void setProductList() {
  //   setState(() {
  //     productsList = productsList.toSet().toList();
  //   });
  // }



  Future <List<dynamic>> getDataForCurrentCategory() async {

    productsContainerForCategory = [];

    productsContainerForCategory = await FetchComplaintCollectionData.getCategoryProductData(categoryStringController);
    //utilFunctions.toastMessageService("productsContainer = ${productsContainerForCategory.length}");

    productsContainerForCategoryFinal = [];   

    for(int i=0; i < productsContainerForCategory.length; i++) {
      final element = productsContainerForCategory[i];
      ProductFetch product = ProductFetch(category: element.category.toString(), name: element.name.toString(), shortDesc: element.shortDesc.toString(), longDesc: element.longDesc.toString(), price: element.price.toString(), image1: element.image1.toString(), image2: element.image2.toString(), image3: element.image3.toString(), image4: element.image4.toString(), quantity: int.parse(element.quantity.toString()), uid: element.uid.toString(), userId: element.userId.toString());
      //utilFunctions.toastMessageService("${element['category']}");
      productsContainerForCategoryFinal.add(product);
    }
    return productsContainerForCategoryFinal;
  }
  

  @override
  Widget build(BuildContext context) {

    // if(productsList != productsContainerForCategoryFinal) {
    //   productsList = productsContainerForCategoryFinal; 
    // }

    
      appBarStringController(categoryStringController);
    
      return  Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),

      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError) {
              return Scaffold(
                    appBar: AppBarWidget().build(context),
                    drawer: DrawerWidget(),

                    body: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Text("Could Not Fetch Data.", textScaleFactor: 1.5,),
                            ),
                          ],
                        ),
                      ),
                    )
                );
            }


            else if(snapshot.hasData) {
              final data = snapshot.data as List<dynamic>;
              if(data.isNotEmpty) {
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
        
                              itemCount: data.length,
                              itemBuilder: (context, index)  {
                                return ProductDisplayContainer(
                                  item: data[index],
                                );
                                
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }

              else{
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                           Center(
                            child: Text(
                              "New items coming soon.",
                              style: TextStyle(
                                fontFamily: GoogleFonts.lato().fontFamily,
                              ),
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }
              
            }
          }


          return Center(
            child: CircularProgressIndicator(),
          );
        },

        future: getDataForCurrentCategory(),
      ),
      
      
      // Padding(
      //   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         SingleChildScrollView(
      //           child: ListView.builder(
      //             shrinkWrap: true,
      //             physics: NeverScrollableScrollPhysics(),
      //             itemCount: productsContainerForCategoryFinal.length,
      //             itemBuilder: (context, index)  {
      //               //setProductList();
      //               productsContainerForCategoryFinal = productsContainerForCategoryFinal.toSet().toList();  
                    
      //               utilFunctions.toastMessageService("${productsContainerForCategoryFinal.length}");
      //               return ProductDisplayContainer(
      //                 item: productsContainerForCategoryFinal[index],
      //               );
                    
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
    }

//     else{
//       return Scaffold(
//       appBar: AppBarWidget().build(context),
//       drawer: DrawerWidget(),

//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Center(
//                 child: Text("Could Not Fetch Data.", textScaleFactor: 1.5,),
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//     }
    
//   }
// }
}