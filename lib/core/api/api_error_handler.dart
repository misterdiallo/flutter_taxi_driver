import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:taxi_driver_app/ui/styles/colors.dart';

const context = BuildContext;

class ApiErrorHandler {
  final String errorName;
  final int errorCode;
  final String errorMessage;
  final Map<String, String> errorHeader;
  final String errorBody;

  ApiErrorHandler(
    this.errorName,
    this.errorCode,
    this.errorMessage,
    this.errorHeader,
    this.errorBody,
  );

  // networkError(erro) {}
  // credentialError(error) {}
  // durationError() {}
}

Map displayEror(
    {required ApiErrorHandler errorHandler, bool showTost = false}) {
  Map<String, dynamic> error = {
    "errorCode": errorHandler.errorCode,
    "errorBody": errorHandler.errorMessage
  };
  if (showTost) {
    showErrorToast(message: error['errorCode'].toString());
  }
  return error;
}

showErrorToast({
  required String message,
  void Function()? onDismiss,
  Duration? duration,
  BuildContext? context,
}) {
  return showToast(
    message,
    context: context,
    backgroundColor: dprimaryColor,
    radius: 15,
    onDismiss: onDismiss,
    duration: duration,
    dismissOtherToast: true,
    position: ToastPosition.top,
  );
}
