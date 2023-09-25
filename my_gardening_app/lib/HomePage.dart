import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'widgets/bottom_nav_bar_widget.dart';
import 'CategoriesPage.dart';
import 'WishlistPage.dart';
import 'CartPage.dart';
import 'ProfilePage.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
    const MyProfileBottomNavigationBar(),
  ];

  var appBarVariableHome;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  
    });
    
  }

  void setAppBarVariableHome() {
    if(_selectedIndex == 4){
      setState(() {
        appBarVariableHome = null;
      });
    }

    else{
      appBarVariableHome = AppBarWidget().build(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    
    appBarStringController("Home Page.");
    setAppBarVariableHome();
    

    return Scaffold(
      appBar: appBarVariableHome,

      drawer: DrawerWidget(),

      body: pages[_selectedIndex],
      

      bottomNavigationBar: BottomNavigationBar(  
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[  
          
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            backgroundColor: Colors.green , 
            label: "Home"
          ),  
          
          BottomNavigationBarItem(  
            icon: Icon(Icons.category),  
            backgroundColor: Colors.yellow,
            label: "Categories"
          ),  


          BottomNavigationBarItem(  
            icon: Icon(Icons.list),  
            backgroundColor: Colors.blue,  
            label: "Wishlist"
          ),

          BottomNavigationBarItem(  
            icon: Icon(Icons.shopify),  
            backgroundColor: Colors.blue, 
            label: "Cart"
          ),

          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            backgroundColor: Colors.blue, 
            label: "Profile"
          ),

        ],  
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 20,  
        onTap: _onItemTapped,  
        elevation: 5  
      )  

      //bottomNavigationBar: BottomNavBarHome(),
    );
  }
}

