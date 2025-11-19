import 'package:flutter/material.dart';
import 'package:taskey_app/core/utils/app_asset.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.title,
    required this.dateTime,
    required this.priority,
    required this.isCompleted,
    this.onPressed,
  });
  final String title;
  final DateTime dateTime;
  final int priority;
  final bool isCompleted;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff6A6E7C)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Radio(
            value: false,
            groupValue: true,
            onChanged: (value) => onPressed,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff24252C),
                ),
              ),
              Text(
                _formateDate(dateTime),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6E6A7C),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xff24252C)),
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 10, bottom: 4),
            child: Row(
              spacing: 5,
              children: [
                Image.asset(AppAsset.flagIcon),
                Text(
                  priority.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff24252C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formateDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
