import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'controllers/string_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Redirection extends StatefulWidget {
  const Redirection({super.key});

  @override
  State<Redirection> createState() => _RedirectionState();
}

class _RedirectionState extends State<Redirection> {
  @override
  Widget build(BuildContext context) {
    appBarStringController("Redirection");
    return Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),
      body: Center(

          child: InkWell(
              child: Text(
              RedirectionTextStringController, 
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
              textScaleFactor: 1.5,
            ),

            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
            }
          ),
          
        ),
      );
  }
}