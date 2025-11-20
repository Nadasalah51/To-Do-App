import 'package:flutter/material.dart';
import 'package:taskey_app/const.dart';

abstract class AppDialog {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            spacing: 10,
            children: [
              CircularProgressIndicator(color: themeColor),
              Text(
                'loading..',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showError(BuildContext context, {required String error}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text(
            error,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            ),
          ],
        ),
      ),
    );
  }

  static void showMessageAccespt(
    BuildContext context,
    void Function()? onDelete,
  ) {
    showDialog(
      context: context,
      builder: (context) => PopScope(
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(
                'Are You sure ',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: onDelete,
                      color: Color(0xFFFE4A49),
                      child: Text('yes'),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('no'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
