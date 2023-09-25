import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductFetchThroughFirebase {
  
  static Future<void> addProductData(String category, String name, String shortDesc, String longDesc, int quantity, String price, String image1, String image2, String image3, String image4) async {
    final firestore = FirebaseFirestore.instance.collection('ProductsData');
    final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
    await firestore.doc().set({"category":category, "name":name, "shortDesc": shortDesc, "longDesc": longDesc, "price": price, "image1": image1, "image2": image2, "image3": image3, "image4": image4, "quantity": quantity, "userId": currentUser});
  }
}

class AddToContainerFirebase {

  static Future<void> addToWishlist(String userId, String name, String price, String image1, String shortDescription, String productId) async {
    final firestore = FirebaseFirestore.instance.collection('WishlistData');
    await firestore.doc().set({"name":name, "price":price, "image":image1, "productID":productId, "shortDesc": shortDescription, "userId":userId});
  }

  static Future<void> addToCart(String userId, String name, String price, String image1, String shortDescription, String productId, int itemQuantity) async {
    final firestore = FirebaseFirestore.instance.collection('AddToCartData');
    await firestore.doc().set({"name":name, "price": price, "image":image1, "productID": productId, "shortDesc": shortDescription, "itemQuantity": itemQuantity, "userId": userId});
  }

  static Future<void> addToReviews(String productId, double rating, String review, String userId) async {
    final firestore = FirebaseFirestore.instance.collection("ReviewData");
    await firestore.doc().set({"productID":productId, "rating":rating, "review":review, "userId": userId});
  }
}

class GetFromContainerFirebase {

  static Future<List<AddToWishlistContainer>> getWishlist(String userId) async {
    List<AddToWishlistContainer> userCartList = [];
    final firestore = await FirebaseFirestore.instance.collection('WishlistData').where("userId", isEqualTo: userId).get();
    for(int i=0; i<firestore.docs.length; i++) {
      final element = firestore.docs[i].data();
      userCartList.add(AddToWishlistContainer(name: element['name'].toString(), price: element['price'].toString(), image: element['image'].toString(), productId: element['productID'].toString(), shortDesc: element['shortDesc'].toString(), userId: element['userId'].toString()));
    }
    return userCartList.toSet().toList();

  }

  static Future<List<AddToCartContainer>> getCartList(String userId) async {
    Map<AddToCartContainer, int>  mapUserCartList = {};

    List<AddToCartContainer> finalUserCartList = [];

    final firestore = await FirebaseFirestore.instance.collection('AddToCartData').where("userId", isEqualTo: userId).get();
    for(int i=0; i<firestore.docs.length; i++) {
      final element = firestore.docs[i].data();
      final addToCartElement = AddToCartContainer(name: element['name'].toString(), price: element['price'].toString(), image: element['image'].toString(), productId: element['productID'].toString(), shortDesc: element['shortDesc'].toString(), userId: element['userId'].toString(), prodQuantity: int.parse(element['itemQuantity'].toString()));

      print(addToCartElement.name);

      if(mapUserCartList.containsKey(addToCartElement)) {
        mapUserCartList.update(addToCartElement, (value) => value + 1);
      }

      else {
        mapUserCartList[addToCartElement] = 0;
      }
    }

    print(mapUserCartList);

    for(AddToCartContainer key in mapUserCartList.keys){
        key.prodQuantity = mapUserCartList[key];
        finalUserCartList.add(key);
    }

    print(mapUserCartList.keys.toList());

    return mapUserCartList.keys.toSet().toList();
  }

  static Future<List<ReviewContainer>> getReviewOfAProduct(String productId) async {
    List<ReviewContainer> productReview = [];
    final firestore = await FirebaseFirestore.instance.collection('ReviewData').where("productID", isEqualTo: productId).get();
    for(int i = 0; i< firestore.docs.length; i++) {
      final element = firestore.docs[i].data();
      productReview.add(ReviewContainer(prodId: element['productID'].toString(), rating: double.parse(element['rating'].toString()), userId: element['userId'].toString(), review: element['review'].toString()));
    }

    return productReview;
  }

}