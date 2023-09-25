import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gardening_app/controllers/image_service_controller.dart';
import 'package:my_gardening_app/shop/ShoppingPage.dart';
import 'package:my_gardening_app/shop/util_controls/string_resource.dart';

import 'item_data_class.dart';

import 'package:my_gardening_app/controllers/string_controller.dart';

import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';

class ItemWidget extends StatelessWidget {
  final Item? item;

  const ItemWidget({Key? key, required this.item})
  :assert(item != null,),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        leading: Image.network(item!.image1!),
        title: Text(item!.title!),
        subtitle: Text(item!.complaint!),

        onTap: () async {
          image1StringController(item!.image1!);
          image2StringController(item!.image2!);
          image3StringController(item!.image3!);
          image4StringController(item!.image4!);
          titleComplaintStringController(item!.title!);
          complaintStringController(item!.complaint!);
          additionalInfoStringControllerFunction(item!.userUid!);
          completeUidStringControllerFunction(item!.completeUid!);

          utilFunctions.toastMessageService(additionalInfoStringController);

          await getUserData(additionalInfoStringController);

          if(!context.mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, '/complaintimageaccess', (route) => false);

          
        },
      ),
    );
    
    
  }
}

class DescItemHome extends StatelessWidget {
  final ItemDesc? itemDesc;
  const DescItemHome({Key? key, required this.itemDesc})
  :assert(itemDesc != null),
  super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(

    width: 300,

    
    
    decoration: BoxDecoration(
      image: DecorationImage(
        image: Image.network(defaultImageStringForHome).image,
        fit: BoxFit.cover,
      ),
      
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    );
  }
}



class CategoriesConatiner extends StatelessWidget {
  final ItemDesc? item;
  const CategoriesConatiner({Key? key, required this.item})
  :assert(item != null),
  super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: ListTile(
        leading: CircleAvatar(backgroundImage: Image.asset(item!.path!).image, radius: 25),
        title: Text(item!.desc!),
        subtitle: Text(
          "Browse Category",
          style: TextStyle(
            fontFamily: GoogleFonts.lato().fontFamily,
            fontSize: 16.0,
          ),
        ),

        onTap: () {
          categoryStringControllerFunction(item!.desc!);
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => ShoppingPage()));
        },
      ),
    );
  }
}


class ProductDisplayContainer extends StatelessWidget {
  final ProductFetch? item;
  const ProductDisplayContainer({Key? key, required this.item})
  :assert(item != null),
  super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: ListTile(
        key: Key(item!.image1!),
        leading: CircleAvatar(backgroundImage: Image.network(item!.image1!).image),
        trailing: Text(
          item!.price!,
          style: TextStyle(
            fontFamily: GoogleFonts.cantarell().fontFamily,
          ),
        ),
        title: Text(
          item!.name!,
          style: TextStyle(
            fontFamily: GoogleFonts.cantarell().fontFamily,
          ),
        ),
        subtitle: Text(
          item!.shortDesc!,
          style: TextStyle(
            fontFamily: GoogleFonts.cantarell().fontFamily,
          ),
        ),

        onTap: () {
          categoryProductsPage = item!.category!;
          nameProductsPage = item!.name!;
          shortDescProductsPage = item!.shortDesc!;
          longDescProductsPage = item!.longDesc!;
          priceProductsPage = item!.price!;
          quantityProductsPage = item!.quantity!;
          image1ProductsPage = item!.image1!;
          image2ProductsPage = item!.image2!;
          image3ProductsPage = item!.image3!;
          image4ProductsPage = item!.image4!;
          sellerUid = item!.userId!;
          productUid = item!.uid!;

          //utilFunctions.toastMessageService("$image1ProductsPage , $image2ProductsPage, $image3ProductsPage, $image4ProductsPage");

          Navigator.pushNamed(context, "/shop/products/item");
        }
      ),
    );
  }
}


class MainAdministratorPanel extends StatelessWidget {
  final ItemDesc? item;
  const MainAdministratorPanel({Key? key, required this.item})
  :assert(item != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: ListTile(
        leading: CircleAvatar(backgroundImage: Image.asset(item!.path!).image),
        title: Text(item!.desc!),

        onTap: () {
          if(item!.desc! == "Complaint Panel"){
            Navigator.pushNamedAndRemoveUntil(context, "/administratorservice/complaint", (route) => false);
          }

          else if(item!.desc! == "Create Product Panel") {
            Navigator.pushNamedAndRemoveUntil(context, "/administratorservice/create", (route) => false);
          }

        }
      ),
    );
  }
}



class WishlistContainer extends StatelessWidget {
  final AddToWishlistContainer? item;
  const WishlistContainer({Key? key, required this.item})
  :assert(item != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: ListTile(
        leading: CircleAvatar(backgroundImage: Image.network(item!.image!).image),
        title: Text(item!.name!),
        subtitle: Text(item!.shortDesc!),
        trailing: Text(item!.price!),

        onTap: () {
          print("Hello World");

        }
      ),
    );
  }
}

class CartContainer extends StatelessWidget {

  final AddToCartContainer? item;
  const CartContainer({Key? key, required this.item})
  :assert(item != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: ListTile(
        leading: CircleAvatar(backgroundImage: Image.network(item!.image!).image),
        title: Text(item!.name!),
        subtitle: Text("${item!.prodQuantity!}"),
        trailing: Text(item!.price!),

        onTap: () {
          print("Hello World");
        }
      ),
    );
  }
}


class ReviewContainerForShop extends StatelessWidget {

  final ReviewContainer? item;
  const ReviewContainerForShop({Key? key, required this.item})
  :assert(item != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: ListTile(
        title: Text("${item!.rating!}"),
        subtitle: Text(item!.review!),

        onTap: () {
          print("Hello World");
        }
      ),
    );
  }
}