import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

SnackBar snackBarWidget({
  String title = '',
  required String message,
  ContentType? type,
}) {
  return SnackBar(
    duration: Duration(seconds: 1),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title, //'On Snap!',
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: type ?? ContentType.failure,
    ),
  );
}
