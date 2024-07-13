import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressDialog extends StatelessWidget {
  ProgressDialog(data, _color) {
    message = data;
    color = _color;
  }

  String? message;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Dialog(
            elevation: 0,
            backgroundColor: Colors.black45,
            insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                  ),
                );
              },
            )
        )
    );
  }
}
