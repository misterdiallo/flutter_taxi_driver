import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/router.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? onPressed;
  const ErrorDialog({
    Key? key,
    required this.title,
    required this.content,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(10.0),
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor,
            ),
          ),
          onPressed: onPressed ??
              () {
                Get.back();
                Get.offNamed(HomepageRoute);
              },
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
