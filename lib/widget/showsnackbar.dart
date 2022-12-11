import 'package:do_with_me/core/styles/colors.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPurple,
      content: Text(
        message.toString(),
      ),
    ),
  );
}
