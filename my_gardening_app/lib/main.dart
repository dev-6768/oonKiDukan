import 'package:flutter/material.dart';
import 'package:my_gardening_app/NewsPage.dart';
import 'package:my_gardening_app/shop/ShoppingPage.dart';
import 'themes/MyThemeData.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';
import 'ComplaintPage.dart';
import 'EditProfilePage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'RedirectionPage.dart';
import 'complaint/AdministratorComplaintAccess.dart';
import 'widgets/list/image_display_list.dart';
import 'controllers/image_service_controller.dart';
import 'firebase_class/FirebaseControllers.dart';
import 'AdministratorService.dart';
import 'package:my_gardening_app/shop/CreateProduct.dart';
import 'package:my_gardening_app/shop/ProductPage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await executeAsAMainFunction();

  utilFunctions.cancelToastService();

  runApp(const MyApp());
}

 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeData().MyThemeDataForApp(context),
      
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.light
      ),

      debugShowCheckedModeBanner: false,

      initialRoute: "/",

      routes: {
        "/":(context) => HomePage(),
        "/login":(context)=>LoginPage(),
        "/register":(context)=>RegisterPage(),
        "/complaint":(context)=>ComplaintPage(),
        "/editprofile":(context)=>EditProfile(),
        "/redirection":(context)=>Redirection(),
        "/complaintdata":(context)=>AdministratorService(),
        "/complaintimageaccess":(context)=>ImageContainerBox(),
        "/administratorservice/complaint":(context)=>AuthorizedComplaintAccess(),
        "/administratorservice/create":(context)=>CreatePage(),
        "/shop/products":(context)=>ShoppingPage(),
        "/shop/products/item":(context)=>ProductPage(),
        "/newsupdates":(context)=>NewsPageWidget(),
      }
    ); 
  }
}
