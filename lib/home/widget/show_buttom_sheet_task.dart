import 'package:flutter/material.dart';
import 'package:taskey_app/auth/widgets/text_form_feild_widget.dart';
import 'package:taskey_app/core/network/result_firebase.dart';
import 'package:taskey_app/core/utils/app_asset.dart';
import 'package:taskey_app/core/utils/app_dialog.dart';
import 'package:taskey_app/core/utils/valditor.dart';
import 'package:taskey_app/home/data/firebase/firebase_task.dart';
import 'package:taskey_app/home/data/model/task_model.dart';
import 'package:taskey_app/home/widget/priority_widget.dart';

class ShowButtomSheetTask extends StatefulWidget {
  const ShowButtomSheetTask({super.key});

  @override
  State<ShowButtomSheetTask> createState() => _ShowButtomSheetTaskState();
}

class _ShowButtomSheetTaskState extends State<ShowButtomSheetTask> {
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: 30 + keyboardHeight,
        left: 24,
        right: 24,
        top: 15,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff24252C),
              ),
            ),
            TextFormFieldWidget(
              controller: taskName,
              hintText: 'Enter task name',
              validator: Validator.validateName,
            ),
            TextFormFieldWidget(
              controller: description,
              hintText: 'Description',
              validator: Validator.validateName,
            ),
            Row(
              spacing: 10,
              children: [
                icon(
                  imagePath: AppAsset.timerIcon,
                  onpressed: () async {
                    selectedDate =
                        await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                          initialDate: DateTime.now(),
                        ) ??
                        DateTime.now();
                  },
                ),
                icon(
                  imagePath: AppAsset.flagIcon,
                  onpressed: () {
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      builder: (context) => PriorityWidget(
                        onTap: (index) {
                          priorityIndex = index;
                        },
                      ),
                    );
                  },
                ),
                const Spacer(),
                icon(
                  imagePath: AppAsset.sendIcon,
                  onpressed: _onPressedSendTask,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget icon({required String imagePath, required void Function() onpressed}) {
    return InkWell(onTap: onpressed, child: Image.asset(imagePath));
  }

  void _onPressedSendTask() async {
    AppDialog.showLoading(context);
    final result = await FirebaseTask.addTask(
      TaskModel(
        title: taskName.text,
        description: description.text,
        selectedDate: selectedDate,
        priorityIndex: priorityIndex,
      ),
    );
    switch (result) {
      case SuccessFB<void>():
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      case ErrorFB<void>():
        Navigator.of(context).pop();
        return AppDialog.showError(context, error: result.messageError);
    }
  }

  late TextEditingController taskName;
  late TextEditingController description;
  late DateTime selectedDate;
  late int priorityIndex;
  @override
  void initState() {
    taskName = TextEditingController();
    description = TextEditingController();
    selectedDate = DateTime.now();
    priorityIndex = 1;
    super.initState();
  }

  @override
  void dispose() {
    taskName.dispose();
    description.dispose();
    super.dispose();
  }
}
