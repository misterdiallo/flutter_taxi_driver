import 'package:flutter/material.dart';

class TitleWithLineWidget extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final Color? lineColor;
  final double lineHeight;
  final double lineWidth;

  const TitleWithLineWidget({
    Key? key,
    required this.title,
    this.textStyle,
    this.lineColor = Colors.grey,
    this.lineHeight = 1.0,
    this.lineWidth = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8.0),
            height: lineHeight,
            color: lineColor,
          ),
        ),
        Text(
          title,
          style: textStyle ?? Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8.0),
            height: lineHeight,
            color: lineColor,
          ),
        ),
      ],
    );
  }
}
