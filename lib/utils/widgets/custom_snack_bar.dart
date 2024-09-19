import 'package:flutter/material.dart';
import 'package:word_search_app/utils/constants/colors.dart';

void customSnackBar(
  BuildContext context,
  String text,
  bool isError,
) {
  // Android or other platforms
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
      content: Text(text),
    ),
  );
}
