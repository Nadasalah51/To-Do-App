import 'package:flutter/material.dart';
import 'package:taskey_app/core/utils/app_asset.dart';

class PriorityWidget extends StatefulWidget {
  const PriorityWidget({super.key, required this.onTap});
  final void Function(int) onTap;

  @override
  State<PriorityWidget> createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  List<int> priorityList = List.generate(10, (index) => index + 1);
  bool isSelected = false;
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            'Task Priority',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff24252C),
            ),
          ),
          Divider(),
        ],
      ),
      content: Wrap(
        children: priorityList
            .map(
              (index) => _PriorityItemWidget(
                index: index,
                isSelected: selectedIndex == index,
                onTap: () {
                  selectedIndex = index;
                  widget.onTap(index);
                  setState(() {});
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PriorityItemWidget extends StatelessWidget {
  const _PriorityItemWidget({
    required this.index,
    this.onTap,
    required this.isSelected,
  });
  final int index;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: isSelected ? null : Border.all(color: Color(0xff24252C)),

          color: isSelected ? Color(0xff5F33E1) : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        margin: EdgeInsets.only(left: 16, top: 12),
        child: Column(
          spacing: 5,
          children: [
            Image.asset(
              AppAsset.flagIcon,
              color: isSelected ? Color(0xffFFFFFF) : null,
            ),
            Text(
              index.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isSelected ? Color(0xffFFFFFF) : Color(0xff24252C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
