import 'package:flutter/material.dart';

class Failure implements Exception {
  final String message;

  Failure({this.message = "Something went wrong"}) : super();

  SnackBar toSnackBar([Function retryAction]) {
    return (retryAction != null)
        ? SnackBar(
      content: Text(message),
      duration: Duration(days: 365),
      action: retryAction != null
          ? SnackBarAction(
        label: "Retry",
        onPressed: retryAction,
      )
          : null,
    )
        : SnackBar(content: Text(message));
  }
}
