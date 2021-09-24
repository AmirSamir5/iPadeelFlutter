import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';

class ListTileWidget extends StatefulWidget {
  final int currentIndex;
  final int widgetIndex;
  final String title;
  final IconData icon;
  final Function onTap;
  const ListTileWidget({
    Key? key,
    required this.currentIndex,
    required this.widgetIndex,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  _ListTileWidgetState createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: (widget.currentIndex == widget.widgetIndex)
          ? AppColors.secondaryColor
          : Colors.black,
      child: ListTile(
        title: Text(widget.title,
            style: TextStyle(
              color: (widget.currentIndex == widget.widgetIndex)
                  ? Colors.black
                  : Colors.white,
            )),
        leading: Icon(
          widget.icon,
          color: (widget.currentIndex == widget.widgetIndex)
              ? Colors.black
              : Colors.white,
        ),
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }
}
