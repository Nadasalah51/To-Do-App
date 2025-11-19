import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskey_app/auth/screens/login_screen.dart';
import 'package:taskey_app/core/network/result_firebase.dart';
import 'package:taskey_app/core/utils/app_asset.dart';
import 'package:taskey_app/core/utils/app_dialog.dart';
import 'package:taskey_app/home/data/firebase/firebase_task.dart';
import 'package:taskey_app/home/data/model/task_model.dart';
import 'package:taskey_app/home/widget/item_card_widget.dart';
import 'package:taskey_app/home/widget/show_buttom_sheet_task.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<TaskModel> listOfTask = [];
  DateTime _selectedValue = DateTime.now();
  @override
  void initState() {
    isLoading = true;
    super.initState();
    getTask(_selectedValue);
  }

  void getTask(DateTime date) async {
    final result = await FirebaseTask.getTasks(date);
    switch (result) {
      case SuccessFB<List<TaskModel>>():
        listOfTask = result.data ?? [];
      case ErrorFB<List<TaskModel>>():
        AppDialog.showError(context, error: result.messageError);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAsset.logo),
        actions: [
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Row(
              children: [
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
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          DatePicker(
            DateTime.now(),
            height: 100,
            initialSelectedDate: DateTime.now(),
            selectionColor: Color(0xff5F33E1),
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              _selectedValue = date;
              getTask(date);
              setState(() {});
            },
          ),
          isLoading ? _loadingState() : _listOfTasks(),
        ],
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
    ).whenComplete(() {
      getTask(_selectedValue);
    });
  }

  Widget _loadingState() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }

  Widget _listOfTasks() {
    return Expanded(
      child: listOfTask.isEmpty
          ? _emptyState()
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (context, index) => ItemCardWidget(
                title: listOfTask[index].title ?? ' ',
                dateTime: listOfTask[index].selectedDate ?? DateTime.now(),
                priority: listOfTask[index].priorityIndex ?? 1,
                isCompleted: listOfTask[index].isCompleted ?? false,
              ),
              itemCount: listOfTask.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 16),
            ),
    );
  }

  Widget _emptyState() {
    return Center(
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
    );
  }
}
