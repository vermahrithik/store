import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ColorConstants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.sp),
        child: Column(
          children: [
            SizedBox(
              height: 10.sp,
            ),
            AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 50,
                  height: 50,
                  margin:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ElevatedButton(
                    child: Icon(CupertinoIcons.gear_alt,
                        color: Colors.grey.shade600),
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.grey.shade300),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: ColorConstants.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
