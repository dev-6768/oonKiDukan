import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gardening_app/controllers/image_service_controller.dart';
import 'package:my_gardening_app/controllers/string_controller.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:url_launcher/url_launcher.dart';
import '/firebase_class/FirebaseControllers.dart';
import 'package:google_fonts/google_fonts.dart';
import '/secret/AdministratorAccess.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_gardening_app/widgets/list/list_item.dart';
import 'string_resources_for_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>  {
  
  static List<String> profileArray = [];
  void setStateOfProfileArray() {
    setState(() {
      profileArray = publicUserData;  
    });
    
  }

  @override
  Widget build(BuildContext context) {

  setStateOfProfileArray();
  
  if(profileArray[0] == null || profileArray[0] == ""){
    profileArray[0] = "User";
  }

  if(profileArray[3] == null || profileArray[3] == ""){
    profileArray[3] = "Login to view your email.";
  }

  if(profileArray[5] == null || profileArray[5] == ""){
    profileArray[5] = "https://asia.olympus-imaging.com/content/000107506.jpg";
  }

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              accountName: Text(profileArray[0], textScaleFactor: 1.3),
              accountEmail: Text(profileArray[3]),
              margin: EdgeInsets.zero,
              currentAccountPicture: CircleAvatar(backgroundImage: Image.network(profileArray[5]).image),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text("Home", style:TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () {
              Navigator.pushNamed(context, "/");
            }
          ),

          ListTile(
            leading: Icon(Icons.email, color: Colors.black),
            title: Text("Edit Profile", style:TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () async {
              if(FirebaseAuth.instance.currentUser == null){
                redirectionTextStringController("Login first to edit a profile.");
                Navigator.pushNamedAndRemoveUntil(context, "/redirection", (route)=>false);
              }

              else{
                await executeAsAMainFunction();
                Navigator.pushNamedAndRemoveUntil(context, "/editprofile", (route)=>false);
              }
              
            }
          ),

          ListTile(
            leading: Icon(Icons.login, color: Colors.black),
            title: Text("Login", style: TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
            },
          ),
          
          ListTile(
            leading: Icon(Icons.admin_panel_settings, color: Colors.black),
            title: Text("Administrator panel", style: TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () async {
              List<String> administratorAccessData = await FetchUserRoleFromCloudFirestore.administratorComplaintAccess();
              
              if(FirebaseAuth.instance.currentUser == null){
                utilFunctions.toastMessageService("You are not authorized to view this information. Try to login from administrator account.");
              }

              else if(!administratorAccessData.contains(FirebaseAuth.instance.currentUser!.uid.toString())) {
                utilFunctions.toastMessageService("Login from the administrator account.");
              }

              else{
                Navigator.pushNamedAndRemoveUntil(context, '/complaintdata', (route)=>false);
              }
            },
          ),

        
          ListTile(
            leading: Icon(Icons.app_registration, color: Colors.black),
            title: Text("Register", style: TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/register', (route)=>false);
            }
          ),

          ListTile(
            leading: Icon(Icons.book, color: Colors.black),
            title: Text("File a complaint", style: TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () {
              if(FirebaseAuth.instance.currentUser == null) {
                redirectionTextStringController("Login first to file a complaint.");
                Navigator.pushNamedAndRemoveUntil(context, "/redirection", (route) => false);
              }
              else{
                Navigator.pushNamedAndRemoveUntil(context, "/complaint", (route)=>false);
              }
              
            }
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.black),
            title: Text("Sign out", style: TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () {
              RegisterUserDetails.signOutUser();
            }
          ),

          ListTile(
            leading: Icon(Icons.update_sharp, color: Colors.black),
            title: Text("News Updates", style: TextStyle(color: Colors.black), textScaleFactor: 1.1),
            onTap: () async {
              if(await canLaunchUrl(Uri.parse(newsFetchUrl))) {
                await launchUrl(Uri.parse(newsFetchUrl));
              }
            }
          ),
        ],
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
      PreferredSizeWidget appBarLayout = AppBar(
        backgroundColor: Colors.green,
        title: Text(
          AppBarStringController,
          textScaleFactor: 1.3,
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
      );

      return appBarLayout;
  }
}

class SizedBoxWidget extends StatelessWidget {
  const SizedBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 10.0);
  }
}

class SizedBoxWidget5 extends StatelessWidget {
  const SizedBoxWidget5({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 5.0);
  }
}



class TopCardViewImageLayout extends StatefulWidget {
  final String displayText;
  final String images;
  const TopCardViewImageLayout(this.displayText, this.images);

  //const TopCardViewImageLayout({super.key});

  @override
  State<TopCardViewImageLayout> createState() => _TopCardViewImageLayoutState();
}

class _TopCardViewImageLayoutState extends State<TopCardViewImageLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundImage: Image.asset(widget.images).image, radius: 25),
        SizedBoxWidget5(),
        Text(
          widget.displayText,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
          
        ),
      ],
    );
    
  }
}




class TopCardViewImageLayoutThirty extends StatefulWidget {
  final String displayText;
  final String images;
  final double imageRadius;
  const TopCardViewImageLayoutThirty(this.displayText, this.images, this.imageRadius);

  //const TopCardViewImageLayoutThirty({super.key});

  @override
  State<TopCardViewImageLayoutThirty> createState() => _TopCardViewImageLayoutThirtyState();
}

class _TopCardViewImageLayoutThirtyState extends State<TopCardViewImageLayoutThirty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundImage: Image.asset(widget.images).image, radius: widget.imageRadius),
        SizedBoxWidget5(),
        Text(
          widget.displayText,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          
        ),
      ],
    );
  }
}




class TopCardViewHome extends StatefulWidget {
  const TopCardViewHome({super.key});

  @override
  State<TopCardViewHome> createState() => _TopCardViewHomeState();
}

class _TopCardViewHomeState extends State<TopCardViewHome> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: backgroundHomeColorForGreenTheme,
      elevation: 10.0,
      
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),

      child: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          
          SizedBox(height: 20),

          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,

              children: [
              TopCardViewImageLayout("Garden", gardenTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Furniture", furnitureTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Bulbs", bulbsTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Plants", plantsTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Tools", toolsTopContainer),
            ]),
          ),

          SizedBoxWidget(),

          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            
              children: [
              TopCardViewImageLayout("Pots", potsTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Pebbles", pebblesTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Fertilizers", fertilizersTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Seeds", seedTopContainer),
              SizedBox(width: 10),
              TopCardViewImageLayout("Accessories", accessoriesTopContainer),
            ]),
          ),

          SizedBox(height: 20),
        ]
      ),
      ),
    );
  }
}


class CarouselViewHome extends StatefulWidget {
  const CarouselViewHome({super.key});

  @override
  State<CarouselViewHome> createState() => _CarouselViewHomeState();
}

class _CarouselViewHomeState extends State<CarouselViewHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: [
          CarouselSlider(
              items: [
                //1st Image of Slider
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
                  
                //2nd Image of Slider
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
                  
                //3rd Image of Slider
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
                  
                //4th Image of Slider
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
                  
                //5th Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: Image.asset(furnitureTopContainer).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
  
          ],
              
            //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),

              disableGesture: false,
          ),
        ],
      );
  }
}


class OrderPanelTop extends StatefulWidget {
  const OrderPanelTop({super.key});

  @override
  State<OrderPanelTop> createState() => _OrderPanelTopState();
}

class _OrderPanelTopState extends State<OrderPanelTop> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: backgroundHomeColorForGreenTheme,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children:[
          SizedBox(height: 20),

          Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            
              children: [
              SizedBox(width: 20),
              TopCardViewImageLayout("Help Center", helpTopContainer),
              SizedBox(width: 20),
              TopCardViewImageLayout("Track Order", trackingTopContainer),
              SizedBox(width: 20),
              TopCardViewImageLayout("Rewards", rewardsTopContainer),
              SizedBox(width: 20),
              TopCardViewImageLayout("Offers", offersTopContainer),
              SizedBox(width: 20),
            ]

          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DiscountMiddleHome extends StatefulWidget {
  const DiscountMiddleHome({super.key});

  @override
  State<DiscountMiddleHome> createState() => _DiscountMiddleHomeState();
}

class _DiscountMiddleHomeState extends State<DiscountMiddleHome> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: backgroundHomeColorForGreenTheme,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children:[
          SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            
              children: [
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Help Center", helpTopContainer, 30),
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Track Order", trackingTopContainer, 30),
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Rewards", rewardsTopContainer, 30),
              SizedBox(width: 20),
            ]

          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}


class MiddleListViewHome extends StatefulWidget {
  const MiddleListViewHome({super.key});

  @override
  State<MiddleListViewHome> createState() => _MiddleListViewHomeState();
}

class _MiddleListViewHomeState extends State<MiddleListViewHome> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ItemsForCatalogue.CatalogueList.length,
      itemBuilder:(context, index) {
        return DescItemHome(
          itemDesc: ItemsForCatalogue.CatalogueList[index]
        );
      },
      

    );
  }
}


class TrendingTabHome extends StatefulWidget {
  const TrendingTabHome({super.key});

  @override
  State<TrendingTabHome> createState() => _TrendingTabHomeState();
}

class _TrendingTabHomeState extends State<TrendingTabHome> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: backgroundHomeColorForGreenTheme,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children:[
          SizedBox(height: 20),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            
              children: [
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Help Center", helpTopContainer, 30),
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Track Order", trackingTopContainer, 30),
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Rewards", rewardsTopContainer, 30),
              SizedBox(width: 20),
            ]

          ),

          SizedBoxWidget(),
          SizedBoxWidget(),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,

              children: [
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Help Center", helpTopContainer, 30),
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Track Order", trackingTopContainer, 30),
              SizedBox(width: 20),
              TopCardViewImageLayoutThirty("Rewards", rewardsTopContainer, 30),
              SizedBox(width: 20),
            ]
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OnPressContainerHome extends StatefulWidget {
  const OnPressContainerHome({super.key});

  @override
  State<OnPressContainerHome> createState() => _OnPressContainerHomeState();
}

class _OnPressContainerHomeState extends State<OnPressContainerHome> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: Image.network(defaultImageStringForHome).image,
            fit: BoxFit.cover,
          ),

          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),

        width: 300,
        height: 200,
      ),
    );
  }
}



class VariableCarouselView extends StatefulWidget {
  
  final List<Widget> CarouselViewList;

  const VariableCarouselView(this.CarouselViewList);

  @override
  State<VariableCarouselView> createState() => _VariableCarouselViewState();
}

class _VariableCarouselViewState extends State<VariableCarouselView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: [
          CarouselSlider(
              items: widget.CarouselViewList,
            //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),

              disableGesture: false,
          ),
        ],
      );
  }
}

class ContactHomePage extends StatefulWidget {
  const ContactHomePage({super.key});

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 10.0,
    color: backgroundHomeColorForGreenTheme,
    child: Column(
      children: [
        SizedBox(height: 20),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            
              children: [
              SizedBox(width: 10),
              TopCardViewImageLayoutThirty("facebook", gardenTopContainer, 25),
              SizedBox(width: 10),
              TopCardViewImageLayoutThirty("whatsapp", pebblesTopContainer, 25),
              SizedBox(width: 10),
              TopCardViewImageLayoutThirty("twitter", seedTopContainer, 25),
              SizedBox(width: 10),
              TopCardViewImageLayoutThirty("pinterest", toolsTopContainer, 25),
              SizedBox(width: 10),
              TopCardViewImageLayoutThirty("instagram", bulbsTopContainer, 25),
              SizedBox(width: 10),
            ]

          ),

          SizedBox(height: 20),
      ],
    ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final InputBorder inputBorder;
  final TextEditingController textController;
  final bool obscureText;

  TextFormFieldWidget(this.hintText, this.labelText, this.inputBorder, this.textController, {this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: inputBorder,
        hintText: hintText,
        labelText: labelText,
      ),

      controller: textController,
      obscureText: obscureText,
    );
  }
}