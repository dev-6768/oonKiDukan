import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list/item_data_class.dart';
  
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  
  

  Widget build(BuildContext context) {
    const bgHomeColor = Color.fromARGB(255, 159, 245, 159);

    return Container(
      color: bgHomeColor,
      child: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Container(
        
        color: bgHomeColor,
        child: SingleChildScrollView(
        
        child: Column(
          children:[

            Center(
              child: Text(
                "Essentials - 15% Discount",
                style: TextStyle(
                  fontFamily: GoogleFonts.calligraffitti().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),

                textScaleFactor: 1.2,
              ),
            ),
            
            Center(
              child: Center(
                child: TopCardViewHome(),
              ),
            ),

            SizedBoxWidget(),

            Center(
            child: Text(
              "Top Picks",
              style: TextStyle(
                fontFamily: GoogleFonts.calligraffitti().fontFamily,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),

              textScaleFactor: 1.2,
            ),
            ),
            

            Center(
              child:Center(
                child: Container(
                  child: CarouselViewHome(),
                  width: 500,
                  height: 200,
                ),
              ),
            ),

            SizedBoxWidget(),

            Center(
              child: Text(
                "Rewards & Offers",
                style: TextStyle(
                  fontFamily: GoogleFonts.calligraffitti().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),

                textScaleFactor: 1.2,
              ),
            ),

            SizedBoxWidget(),

            Center(
              child:Center(
                child: OrderPanelTop(),
              )
            ),

            SizedBoxWidget(),

            Center(
              child: DiscountMiddleHome(),
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Text(
              "Value for money - Upto 35% off", 
              style: TextStyle(fontFamily: GoogleFonts.calligraffitti().fontFamily, fontSize: 16.0, fontWeight: FontWeight.bold,),
              
              textScaleFactor: 1.1,
            ),

            SizedBoxWidget(),

            SingleChildScrollView(

              child:Container(
                child: MiddleListViewHome(),
                width: 300,
                height: 200,
              ),
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Text(
              "Bestseller Plants", 
              style: TextStyle(fontFamily: GoogleFonts.calligraffitti().fontFamily, fontSize: 16.0, fontWeight: FontWeight.bold,),
              textScaleFactor: 1.1,
            ),

            SizedBoxWidget(),

            Center(
              child: CarouselViewHome(),
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Center(
              child: TrendingTabHome(),
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Text(
              "What's New",
              style: TextStyle(
                fontFamily: GoogleFonts.calligraffitti().fontFamily,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.3,
            ),

            SizedBoxWidget(),

            Center(
              child: OnPressContainerHome(),
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Text(
              "Our Blogs",
              style: TextStyle(
                fontFamily: GoogleFonts.calligraffitti().fontFamily,
                fontWeight: FontWeight.bold,
              ),

              textScaleFactor: 1.3,
            ),

            SizedBoxWidget(),

            Center(
              child: VariableCarouselView(ItemsForCatalogue.BlogList),
            ),

            SizedBoxWidget(),
            SizedBoxWidget(),

            Text(
              "Reach Us",
              style: TextStyle(
                fontFamily: GoogleFonts.calligraffitti().fontFamily,
                fontWeight: FontWeight.bold
              ),

              textScaleFactor: 1.3,
            ),

            SizedBoxWidget(),

            Center(
              child: ContactHomePage(),
            ),
            
          ],
        ),
      ),
      ),
      ),
    );
  }
}