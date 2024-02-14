import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/controllers/controllers.dart';

class Dispatcher extends StatefulWidget {
  const Dispatcher({Key? key}) : super(key: key);

  @override
  State<Dispatcher> createState() => _DispatcherState();
}

class _DispatcherState extends State<Dispatcher> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
