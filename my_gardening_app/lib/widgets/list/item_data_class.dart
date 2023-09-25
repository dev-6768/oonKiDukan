import 'package:flutter/material.dart';
import 'package:my_gardening_app/shop/util_controls/string_resource.dart';
import 'package:my_gardening_app/widgets/string_resources_for_widget.dart';

class Item {
  final String? title;
  final String? complaint;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? userUid;
  final String? completeUid;

  Item({this.title, this.complaint, this.image1, this.image2, this.image3, this.image4, this.userUid, this.completeUid});
}

class ItemDesc {
  final String? path;
  final String? desc;

  ItemDesc({this.path, this.desc});
}

class ProductFetch {
  final String? uid;
  final String? category;
  final String? name;
  final String? shortDesc;
  final String? longDesc;
  final String? price;
  final int? quantity;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? userId;

  ProductFetch({this.uid, this.category, this.name, this.shortDesc, this.longDesc, this.price, this.quantity, this.image1, this.image2, this.image3, this.image4, this.userId});
}

class AddToWishlistContainer {
  final String? name;
  final String? price;
  final String? image;
  final String? productId;
  final String? shortDesc;
  final String? userId;

  @override
  bool operator ==(Object other) => other is AddToWishlistContainer && productId == other.productId && userId == other.userId;
  int get hashCode => Object.hash(productId, userId);

  AddToWishlistContainer({this.name, this.price, this.image, this.productId, this.shortDesc, this.userId});
}

class AddToCartContainer {
  final String? name;
  final String? price;
  final String? image;
  final String? productId;
  final String? shortDesc;
  final String? userId;
  int? prodQuantity;

  @override
  bool operator ==(Object other) => other is AddToCartContainer && productId == other.productId;
  int get hashCode => Object.hash(productId, productId);

  AddToCartContainer({this.name, this.price, this.image, this.productId, this.shortDesc, this.userId, this.prodQuantity});
}

class ReviewContainer {
  final String? prodId;
  final double? rating;
  final String? review;
  final String? userId;

  ReviewContainer({this.prodId, this.rating, this.review, this.userId});
}

class ItemsForCatalogue {
  static final CatalogueList = [
    ItemDesc(path: "https://asia.olympus-imaging.com/content/000107506.jpg", desc:"sample"),
    ItemDesc(path: "https://asia.olympus-imaging.com/content/000107506.jpg", desc:"sample"),
    ItemDesc(path: "https://asia.olympus-imaging.com/content/000107506.jpg", desc:"sample"),
    ItemDesc(path: "https://asia.olympus-imaging.com/content/000107506.jpg", desc:"sample"),
    ItemDesc(path: "https://asia.olympus-imaging.com/content/000107506.jpg", desc:"sample"),
  ];


  static final BlogList = [
                //1st Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.asset(bulbsTopContainer).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //2nd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.asset(accessoriesTopContainer).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //3rd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.asset(pebblesTopContainer).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //4th Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.asset(seedTopContainer).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //5th Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.asset(plantsTopContainer).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
  
          ];

  static final categoriesList = [
    ItemDesc(path: bulbsTopContainer, desc: "Bulbs"),
    ItemDesc(path: accessoriesTopContainer, desc: "Accessories"),
    ItemDesc(path: fertilizersTopContainer, desc: "Fertilizers"),
    ItemDesc(path: furnitureTopContainer, desc: "Furniture"),
    ItemDesc(path: gardenTopContainer, desc: "Gardening Supplies"),
    ItemDesc(path: pebblesTopContainer, desc: "Pebbles"),
    ItemDesc(path: plantsTopContainer, desc: "Plants"),
    ItemDesc(path: potsTopContainer, desc: "Pots"),
    ItemDesc(path: seedTopContainer, desc: "Seeds"),
    ItemDesc(path: toolsTopContainer, desc: "Tools"),
  ];


  static final administratorList = [
    ItemDesc(path: bulbsTopContainer, desc: "Complaint Panel"),
    ItemDesc(path: accessoriesTopContainer, desc: "Create Product Panel"),
  ];


  static var productItemList = [
                //1st Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.network(image1ProductsPage).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //2nd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.network(image2ProductsPage).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //3rd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.network(image3ProductsPage).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                //4th Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.network(image4ProductsPage).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
  
          ];
}
