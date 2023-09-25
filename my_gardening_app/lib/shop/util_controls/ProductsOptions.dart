import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';
import 'package:my_gardening_app/shop/shop_controller/ShopFirebaseController.dart';
import 'package:my_gardening_app/widgets/list/list_item.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:my_gardening_app/shop/util_controls/string_resource.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProductHome extends StatefulWidget {
  const ProductHome({super.key});

  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {

  int counterVariable = 0;
  void _incrementCounterVariable() {
    setState(() {
      if(counterVariable < 10) {
        counterVariable += 1;  
      }
      
    });
  }

  void _decrementCounterVariable() {
    setState(() {
      if(counterVariable > 1){
        counterVariable -= 1;  
      }
      
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Center(
              child: VariableCarouselView(ItemsForCatalogue.productItemList),
            ),

            SizedBoxWidget5(),

            Center(
              child: Text(
                "$nameProductsPage",
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontSize: 16.0,
                ),
              ),
            ),

            SizedBoxWidget5(),

            Text(
              "₹$priceProductsPage",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
              textScaleFactor: 1.5,
            ),

            SizedBoxWidget(),

            Text(
              shortDescProductsPage,
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                color: Color.fromARGB(255, 124, 121, 121)
              ),
              textScaleFactor: 1.15,
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Container(
              width: 500,
              height: 150,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quantity : ",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontSize: 16.0,
                  ),
                ),

                SizedBox(height: 5),

                ElevatedButton(onPressed: _incrementCounterVariable, child: Text("+")),

                SizedBoxWidget5(),

                Text(
                  "$counterVariable",
                  style:TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontSize: 16.0,
                  ),
                ),

                SizedBoxWidget5(),

                ElevatedButton(onPressed: _decrementCounterVariable, child: Text("-")),

                
              ],
            ),
  
            ),

            SizedBoxWidget(),

            Text(
              "Description",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 15.0,
              ),
            ),

            SizedBoxWidget5(),

            Text(
              longDescProductsPage,
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),

      );
  }
}




class BuyNowProduct extends StatefulWidget {
  const BuyNowProduct({super.key});

  @override
  State<BuyNowProduct> createState() => _BuyNowProductState();
}

class _BuyNowProductState extends State<BuyNowProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical:16.0, horizontal: 16.0),
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Name: $nameProductsPage",
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 16.0,
            ),
          ),
          
          SizedBoxWidget(),

          Text(
            "Category: $categoryProductsPage",
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 16.0,
            ),
          ),
          
          SizedBoxWidget(),

          Text(
            "Product ID: $productUid",
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 16.0,
            ),
          ),

          SizedBoxWidget(),

          Text(
            "Sold By: $sellerUid",
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 16.0,
            ),
          ),

          SizedBoxWidget(),

          Text(
            "Product Price: $priceProductsPage",
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 16.0,
            ),
          ),

          SizedBoxWidget(),

          Center(
            child: VariableCarouselView(ItemsForCatalogue.productItemList),
          ),

          SizedBoxWidget5(),

          Center(
            child: Text(
              shortDescProductsPage,
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 16.0,
              ),
            ),
          ),

          SizedBoxWidget(),

          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Buy Now"),
                onPressed: () {
                  if(FirebaseAuth.instance.currentUser == null) {
                    utilFunctions.toastMessageService("Login first to place an order");
                    Navigator.pushNamed(context, "/login");
                  }

                  else{
                    print("Hello ${FirebaseAuth.instance.currentUser!.uid.toString()}, you have purchased this product");
                  }
                  
                },
              ),
            ),
          ),
        ],
      ),
    ),
      );
      
  }
}




class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  Future <List<AddToWishlistContainer>> getDataForCurrentInstance() async { 
    if(FirebaseAuth.instance.currentUser == null) {
      utilFunctions.toastMessageService("Login to get access to wishlist.");
      return [AddToWishlistContainer()];
    }

    else{
      await AddToContainerFirebase.addToWishlist(FirebaseAuth.instance.currentUser!.uid.toString(), nameProductsPage, priceProductsPage, image1ProductsPage, shortDescProductsPage, productUid);

      List<AddToWishlistContainer> getUserWishlist = await GetFromContainerFirebase.getWishlist(FirebaseAuth.instance.currentUser!.uid);
      
      List<AddToWishlistContainer> getUserWishListFinal = [];
      for(int i = 0; i< getUserWishlist.length; i++) {
        final element = getUserWishlist[i];
        if(element.name.toString() != "" && element.price.toString() != "" && element.image.toString() != "" && element.productId.toString() != "" && element.shortDesc.toString() != "" && element.userId.toString() != "") {
          final product = AddToWishlistContainer(name: element.name.toString(), price: element.price.toString(), image: element.image.toString(), productId: element.productId.toString(), shortDesc: element.shortDesc.toString(), userId: element.userId.toString());
          getUserWishListFinal.add(product);
        }
      }
      return getUserWishListFinal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.hasError){
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
          final data = snapshot.data as List<AddToWishlistContainer>;
          if(data.isNotEmpty && data[0].name != null && data[0].price != null && data[0].image != null && data[0].productId != null && data[0].shortDesc != null && data[0].userId != null) {
            return Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Hello, Your wishlist",
                              style: TextStyle(
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontSize: 16.0,
                              ),
                            ),

                            SizedBoxWidget(),

                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return WishlistContainer(item: data[index]);
                                }
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
      future: getDataForCurrentInstance(),
    );
    
  }
}




class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {

  Future <List<AddToCartContainer>> getDataForCurrentInstance() async { 
    if(FirebaseAuth.instance.currentUser == null) {
      utilFunctions.toastMessageService("Login to get access to cart.");
      return [AddToCartContainer()];
    }

    else{
      await AddToContainerFirebase.addToCart(FirebaseAuth.instance.currentUser!.uid.toString(), nameProductsPage, priceProductsPage, image1ProductsPage, shortDescProductsPage, productUid, itemQuantityForAddToCart);
      List<AddToCartContainer> getUserWishlist = await GetFromContainerFirebase.getCartList(FirebaseAuth.instance.currentUser!.uid);
      
      List<AddToCartContainer> getUserWishListFinal = [];
      for(int i = 0; i< getUserWishlist.length; i++) {
        final element = getUserWishlist[i];
        if(element.name.toString() != "" && element.price.toString() != "" && element.image.toString() != "" && element.productId.toString() != "" && element.shortDesc.toString() != "" && element.userId.toString() != "" && int.parse(element.prodQuantity.toString()) != 0) {
          final product = AddToCartContainer(name: element.name.toString(), price: element.price.toString(), image: element.image.toString(), productId: element.productId.toString(), shortDesc: element.shortDesc.toString(), userId: element.userId.toString(), prodQuantity: int.parse(element.prodQuantity.toString()));
          getUserWishListFinal.add(product);
        }
        
        
      }
      return getUserWishListFinal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.hasError){
          return Scaffold(
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
          final data = snapshot.data as List<AddToCartContainer>;

          if(data.isNotEmpty && data[0].name != null && data[0].price != null && data[0].image != null && data[0].productId != null && data[0].shortDesc != null && data[0].userId != null && data[0].prodQuantity != null) {
            return Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Hello, Your cart",
                              style: TextStyle(
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontSize: 16.0,
                              ),
                            ),

                            SizedBoxWidget(),

                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return CartContainer(item: data[index]);
                                }
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
      future: getDataForCurrentInstance(),
    );
  }
}




class WriteReview extends StatefulWidget {
  const WriteReview({super.key});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {

  Future <List<ReviewContainer>> getDataForCurrentInstance() async { 
    if(FirebaseAuth.instance.currentUser == null) {
      utilFunctions.toastMessageService("Login to get access to reviews.");
      return [ReviewContainer()];
    }

    else{
      //await AddToContainerFirebase.addToReviews(productUid, ratingsForReviewContainer, reviewsForReviewContainer, FirebaseAuth.instance.currentUser!.uid.toString());
      List<ReviewContainer> getUserWishlist = await GetFromContainerFirebase.getReviewOfAProduct(productUid);
      
      List<ReviewContainer> getUserWishListFinal = [];
      for(int i = 0; i< getUserWishlist.length; i++) {
        final element = getUserWishlist[i];
        final product = ReviewContainer(prodId: element.prodId.toString(), rating: element.rating, review: element.review, userId: FirebaseAuth.instance.currentUser!.uid.toString());
        getUserWishListFinal.add(product);
      }
      return getUserWishListFinal;
    }
  }

  String ratingsHolder = "";
  String reviewsHolder = "";


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.hasError){
          return Scaffold(
                    body: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Write a review.",
                              style: TextStyle(
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontSize: 16.0,
                              ),
                            ),

                            SizedBoxWidget(),

                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Ratings, Eg: 1.0, 3.4, 5.0",
                                labelText: "Ratings",
                              ),

                              onChanged: (value) {
                                ratingsHolder = value;
                              }
                            ),

                            SizedBoxWidget(),

                            TextField(
                              decoration: InputDecoration(
                                hintText: "Your reviews.",
                                labelText: "Your reviews.",
                              ),

                              onChanged: (value) {
                                reviewsHolder = value;
                              }
                            ),

                            SizedBoxWidget(),

                            ElevatedButton(
                              child: Text("Submit Review"),
                              onPressed: () async {
                                await AddToContainerFirebase.addToReviews(productUid, double.parse(ratingsHolder), reviewsHolder, FirebaseAuth.instance.currentUser!.uid);
                                utilFunctions.toastMessageService("Your review is submitted successfully.");
                              }
                            ),
                            SizedBoxWidget(),
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
          final data = snapshot.data as List<ReviewContainer>;
          ratingsHolder = "";
          reviewsHolder = "";
          if(data.isNotEmpty && data[0].prodId != null && data[0].userId != null && data[0].rating != null && data[0].review != null) {
            return Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Write a review.",
                              style: TextStyle(
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontSize: 16.0,
                              ),
                            ),

                            SizedBoxWidget(),

                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Ratings, Eg: 1.0, 3.4, 5.0",
                                labelText: "Ratings",
                              ),

                              onChanged: (value) {
                                ratingsHolder = value;
                              }
                            ),

                            SizedBoxWidget(),

                            TextField(
                              decoration: InputDecoration(
                                hintText: "Your reviews.",
                                labelText: "Your reviews.",
                              ),

                              onChanged: (value) {
                                reviewsHolder = value;
                              }
                            ),

                            SizedBoxWidget(),

                            ElevatedButton(
                              child: Text("Submit Review"),
                              onPressed: () async {
                                utilFunctions.toastMessageService("$ratingsHolder, $reviewsHolder");
                                await AddToContainerFirebase.addToReviews(productUid, double.parse(ratingsHolder), reviewsHolder, FirebaseAuth.instance.currentUser!.uid);
                                utilFunctions.toastMessageService("Your review is submitted successfully.");
                              }
                            ),

                            SizedBoxWidget(),

                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length, 
                                itemBuilder: (context, index) {
                                  return ReviewContainerForShop(item: data[index]);
                                }
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
                          Text(
                              "Write a review.",
                              style: TextStyle(
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontSize: 16.0,
                              ),
                            ),

                            SizedBoxWidget(),

                            TextFormField(
                              
                              decoration: InputDecoration(
                                hintText: "Ratings, Eg: 1.0, 3.4, 5.0",
                                labelText: "Ratings",
                              ),

                              onChanged: (value) {
                                ratingsHolder = value;
                              }
                            ),

                            SizedBoxWidget(),

                            TextField(
                              decoration: InputDecoration(
                                hintText: "Your reviews.",
                                labelText: "Your reviews.",
                              ),

                              maxLines: null,

                              onChanged: (value) {
                                reviewsHolder = value;
                              }
                            ),

                            SizedBoxWidget(),

                            ElevatedButton(
                              child: Text("Submit Review"),
                              onPressed: () async {
                                await AddToContainerFirebase.addToReviews(productUid, double.parse(ratingsHolder), reviewsHolder, FirebaseAuth.instance.currentUser!.uid);
                                utilFunctions.toastMessageService("Your review is submitted successfully.");
                              }
                            ),
                          SizedBoxWidget(),
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
      future: getDataForCurrentInstance(),
    );
  }
}