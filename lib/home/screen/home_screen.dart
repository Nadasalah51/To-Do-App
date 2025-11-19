import 'package:flutter/material.dart';
import 'package:taskey_app/core/utils/app_asset.dart';
import 'package:taskey_app/home/widget/show_buttom_sheet_task.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAsset.logo),
        actions: [
          Image.asset(AppAsset.logOutIcon),
          SizedBox(width: 10),
          Text(
            'Log out',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFF4949),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          spacing: 10,
          children: [
            SizedBox(height: 90),
            Image.asset(AppAsset.emptyImage),
            Text(
              'What do you want to do today?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xff58585E),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xff24252C),
        onPressed: _onPressedAddTask,
        child: Icon(Icons.add, color: Color(0xff5F33E1)),
      ),
    );
  }

  void _onPressedAddTask() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShowButtomSheetTask(),
    );
  }
}

