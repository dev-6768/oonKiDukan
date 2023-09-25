import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'package:my_gardening_app/shop/util_controls/string_resource.dart';
import 'package:my_gardening_app/shop/util_controls/ProductsOptions.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List<Widget> productsOptionsList = [
    ProductHome(),
    BuyNowProduct(),
    AddToCart(),
    WishList(),
    WriteReview(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    appBarStringController(categoryProductsPage);


    return Scaffold(
      
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),


      bottomNavigationBar: BottomNavigationBar(  
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[  
          
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            backgroundColor: Colors.green , 
            label: "Product"
          ),  
          
          BottomNavigationBarItem(  
            icon: Icon(Icons.category),  
            backgroundColor: Colors.yellow,
            label: "Buy Now"
          ),  


          BottomNavigationBarItem(  
            icon: Icon(Icons.list),  
            backgroundColor: Colors.blue,  
            label: "Add to cart"
          ),

          BottomNavigationBarItem(  
            icon: Icon(Icons.shopify),  
            backgroundColor: Colors.blue, 
            label: "Add to wish"
          ),

          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            backgroundColor: Colors.blue, 
            label: "Write a review"
          ),

        ],  
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 20,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  



      body: productsOptionsList[_selectedIndex],
      
    );
  }
}
