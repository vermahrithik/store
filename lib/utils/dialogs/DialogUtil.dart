import 'package:store/utils/ColorConstants.dart';
import 'package:store/utils/dialogs/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ColorConstants.dart';

class DialogUtil {
  static late BuildContext dialogContext;

  static showProgressDialog(String message, BuildContext context, Color color) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProgressDialog(message, color);
      },
    );
  }

  static dismissProgressDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static showMessageDialog(String message, BuildContext context, Color color) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text(
              message,
              style: TextStyle(
                  color: ColorConstants.blackColor,
                  fontFamily: 'Medium',
                  fontSize: 13.sp),
              textAlign: TextAlign.start,
            ),
            buttonPadding: EdgeInsets.all(13.w),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(color),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: ColorConstants.WhiteColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Medium',
                      fontSize: 13.sp),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          );
        });
  }
}
