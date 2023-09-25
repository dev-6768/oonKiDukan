import 'package:flutter/material.dart';
import 'EditProfilePage.dart';

class MyProfileBottomNavigationBar extends StatefulWidget {
  const MyProfileBottomNavigationBar({super.key});

  @override
  State<MyProfileBottomNavigationBar> createState() => _MyProfileBottomNavigationBarState();
}

class _MyProfileBottomNavigationBarState extends State<MyProfileBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return const EditProfile();
  }
}