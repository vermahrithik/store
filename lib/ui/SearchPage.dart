import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ProductData.dart';
import '../utils/ColorConstants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<ProductData> showproducts = List.empty(growable: true);
  List<ProductData> filteredProducts = List.empty(growable: true);

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

  readFromSp() {
    List<String>? productListString = sp.getStringList('Products');
    if (productListString != null) {
      showproducts = productListString
          .map((product) => ProductData.fromJson(json.decode(product)))
          .toList();
      filteredProducts = showproducts;
    }
    setState(() {});
  }

  saveIntoSp() {
    List<String> productListString =
    showproducts.map((product) => jsonEncode(product.toJson())).toList();
    sp.setStringList('Products', productListString);
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = showproducts;
    } else {
      filteredProducts = showproducts.where((product) =>
      product.name?.contains(query) ?? false).toList();

    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffAEAEC0).withOpacity(0.24),
                            offset: const Offset(0, 0),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(1),
                            offset: const Offset(0, 0),
                            spreadRadius: -5,
                            blurRadius: 5,
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade400, width: 1),
                      ),
                      child: const Icon(CupertinoIcons.back, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              titleSpacing: 0,
              centerTitle: true,
              title: Container(
                width: deviceWidth * 0.8,
                height: 37,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffAEAEC0).withOpacity(0.24),
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      offset: const Offset(0, 0),
                      spreadRadius: -5,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 14.0,
                    color: ColorConstants.Grey500,
                    fontWeight: FontWeight.w400,
                  ),
                  cursorColor: ColorConstants.Grey500,
                  controller: searchController,
                  onChanged: searchProducts,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    hintText: 'Search Product',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade800.withOpacity(0.8),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: _fetchData,
                      child: SizedBox(child: Icon(Icons.search,size: 22.sp,)),
                    ),
                  ),
                ),
              ),
              backgroundColor: ColorConstants.primaryColor,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight*0.88,
          child: filteredProducts.isNotEmpty
              ? ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorConstants.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 2),
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.sp),
                              child: showproducts[index]
                                  .image !=
                                  null
                                  ? _buildImage(showproducts[index].image!)
                                  : Image.asset(
                                'assets/headset.jpg',
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.width * 0.85,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text(
                              (filteredProducts[index].name ?? 'Unknown').toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.blackColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.sp,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text(
                              "\$${filteredProducts[index].price}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.Grey500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
              : const Center(child: Text('No Product Found')),
        ),
      )
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

  void _fetchData() {
    readFromSp();
  }
}
