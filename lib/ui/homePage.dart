import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/ui/SearchPage.dart';
import '../utils/ColorConstants.dart';
import 'AddProduct.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/ui/AddProduct.dart';
import 'package:store/ui/SplashScreen.dart';
import 'package:store/utils/ColorConstants.dart';

import '../bloc/BasicBloc.dart';
import '../models/ProductData.dart';
import '../utils/dialogs/DialogUtil.dart';
import 'loginPage.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  /// ---------------------------------

  List<ProductData> showproducts = List.empty(growable: true);

  int selectedIndex = -1;

  late SharedPreferences sp;

  @override
  void initState() {
    super.initState();
    getSharedPrefrences();
  }

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {

    List<String> productListString =
        showproducts.map((product) => jsonEncode(product.toJson())).toList();
    sp.setStringList('Products', productListString);

  }

  readFromSp() {

    List<String>? productListString = sp.getStringList('Products');
    if (productListString != null) {
      showproducts = productListString
          .map((product) => ProductData.fromJson(json.decode(product)))
          .toList();
    }
    setState(() {});

  }



  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
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
              actions: [
                Container(
                  width: 35,
                  height: 35,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: OutlinedButton(
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey.shade600,
                        size: 18.sp,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      )),
                ),
                SizedBox(
                  width: 10,
                )
              ],
              backgroundColor: ColorConstants.primaryColor,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: ColorConstants.transparent,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Container(
          color: ColorConstants.primaryColor,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Center(
                child: Text(
                  'H i - F i \nShop & Service',
                  style: TextStyle(fontSize: 25),
                ),
              )),
              ListTile(
                leading: Icon(Icons.logout_rounded),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? userModal = prefs.getString('usermodal');
                  if (userModal != null) {
                    print(jsonDecode(userModal));
                    prefs.remove('usermodal');
                  }
                  DialogUtil.showProgressDialog(
                    "",
                    context,
                    ColorConstants.primaryColorTwo,
                  );
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: ColorConstants.primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10.sp),
                  Text("Hi-Fi Shop & Service",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade900))
                ],
              ),
              SizedBox(
                height: 12.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.sp,
                  ),
                  Text("Audio shop on Rustaveli Ave 57.",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.Grey500))
                ],
              ),
              SizedBox(
                height: 4.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.sp,
                  ),
                  Text("This shop offers both showproducts and services",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.Grey500))
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.sp,
                  ),
                  Container(
                    width: deviceWidth * 0.92,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Products",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900)),
                            SizedBox(
                              width: 4.sp,
                            ),
                            Text(
                              showproducts.length.toString(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.Grey500),
                            )
                          ],
                        ),
                        GestureDetector(
                          child: Text(
                            "Show all",
                            style: TextStyle(
                                color: Color(0xff0065fe),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 0.sp,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: 200,
                      width: deviceWidth * 0.92,
                      child: showproducts.isNotEmpty
                          ? ListView.builder(
                          itemCount: showproducts.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            // final availability =
                            //     showproducts[index]["availability"];
                            // print('Product ${showproducts[index]["name"]} availability: $availability');
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                height: 235,
                                width: 145,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 6.sp,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 130,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                12.sp),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                12.sp),
                                            child: showproducts[index]
                                                .image !=
                                                null
                                                ? _buildImage(showproducts[index].image!)
                                                : Image.asset(
                                              'assets/headset.jpg',
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 95.0, top: 5.0),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  showproducts
                                                      .removeAt(index);
                                                });
                                                saveIntoSp();
                                              },
                                              style: ButtonStyle(
                                                padding:
                                                WidgetStateProperty.all(
                                                    EdgeInsets.zero),
                                                backgroundColor:
                                                WidgetStateProperty.all<
                                                    Color>(
                                                    Colors.transparent),
                                                shape: WidgetStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(9.0),
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons
                                                    .delete_outline_rounded,
                                                color: ColorConstants
                                                    .WhiteColor,
                                                size: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10.sp),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 0.0),
                                                  child: Text(
                                                    showproducts[index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 0.0),
                                                  child: Text(
                                                    "\$${showproducts[index].price.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w400,
                                                        color:
                                                        ColorConstants.Grey500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6.sp,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                          : const Center(
                        child: Text('No Product Found'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.sp,
                  ),
                  Container(
                    width: deviceWidth * 0.92,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Accessories",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900)),
                            SizedBox(
                              width: 4.sp,
                            ),
                            Text(
                              showproducts.length.toString(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.Grey500),
                            )
                          ],
                        ),
                        GestureDetector(
                          child: Text(
                            "Show all",
                            style: TextStyle(
                                color: Color(0xff0065fe),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 0.sp,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: 215,
                      width: deviceWidth * 0.92,
                      child: showproducts.isNotEmpty
                          ? ListView.builder(
                              itemCount: showproducts.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                // final availability =
                                //     showproducts[index]["availability"];
                                // print('Product ${showproducts[index]["name"]} availability: $availability');
                                return Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    height: 235,
                                    width: 145,
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 6.sp,
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 130,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp),
                                                child: showproducts[index]
                                                            .image !=
                                                        null
                                                    ? _buildImage(showproducts[index].image!)
                                                    : Image.asset(
                                                        'assets/headset.jpg',
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 95.0, top: 5.0),
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      showproducts
                                                          .removeAt(index);
                                                    });
                                                    saveIntoSp();
                                                  },
                                                  style: ButtonStyle(
                                                    padding:
                                                        WidgetStateProperty.all(
                                                            EdgeInsets.zero),
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                                Color>(
                                                            Colors.transparent),
                                                    shape: WidgetStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9.0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color: ColorConstants
                                                        .WhiteColor,
                                                    size: 18.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 4.sp,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 10.sp),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 0.0),
                                                      child: Text(
                                                        showproducts[index]
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 0.sp,
                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 0.0),
                                                        child: Text(
                                                          "• Available",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color:
                                                                Colors.green.shade700,
                                                          ),
                                                        )
                                                        // child: availability == true
                                                        //     ? Text(
                                                        //         "• Available",
                                                        //         style: TextStyle(
                                                        //           fontSize: 14.sp,
                                                        //           fontWeight:
                                                        //               FontWeight.w400,
                                                        //           color: Colors
                                                        //               .green.shade700,
                                                        //         ),
                                                        //       )
                                                        //     : Text(
                                                        //         "• Unavailable",
                                                        //         style: TextStyle(
                                                        //           fontSize: 14.sp,
                                                        //           fontWeight:
                                                        //               FontWeight.w400,
                                                        //           color: Colors
                                                        //               .redAccent.shade400,
                                                        //         ),
                                                        //       ),
                                                        ),
                                                    SizedBox(
                                                      height: 0.sp,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 0.0),
                                                      child: Text(
                                                        "\$${showproducts[index].price.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color:
                                                                ColorConstants.Grey500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6.sp,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const Center(
                              child: Text('No Product Found'),
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddProduct()));
          },
          backgroundColor: Color(0xff0065fe),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.sp)),
          child: Icon(
            Icons.add,
            color: ColorConstants.WhiteColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String base64String) {
    try {
      return Image.memory(
        base64Decode(base64String),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.width * 0.85,
        fit: BoxFit.cover,
      );
    } catch (e) {
      print('Exception: Invalid Image Data: $e');
      return Image.asset(
        'assets/headset.jpg',
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.width * 0.85,
        fit: BoxFit.cover,
      );
    }
  }

}
