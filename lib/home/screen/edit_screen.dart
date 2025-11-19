import 'package:flutter/material.dart';
import 'package:taskey_app/const.dart';
import 'package:taskey_app/home/screen/home_screen.dart';
import 'package:taskey_app/home/widget/buttom_is_complete.dart';

class EditScreen extends StatelessWidget {
  static const String routeName = 'EditScreen';
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 130),
        child: Column(
          children: [ButtomIsComplete(onPressed: () {}, isCompleted: false)],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 28),
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
          color: themeColor,
          minWidth: double.infinity,
          height: 48,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
