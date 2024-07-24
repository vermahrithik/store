import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ProductData.dart';
import '../utils/ColorConstants.dart';
import 'homePage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<ProductData> products = List.empty(growable: true);

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
    List<String> productListString = products.map((product) => jsonEncode(product.toJson())).toList();
    sp.setStringList('Products', productListString);
  }

  readFromSp() {
    List<String>? productListString = sp.getStringList('Products');
    if (productListString != null) {
      setState(() {
        products = productListString
            .map((product) => ProductData.fromJson(json.decode(product)))
            .toList();
      });
    }
  }

  /// Image Picker Upload Section:
  XFile? _image;
  String? _fileName;
  String? _base64Image;

  final ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = pickedImage;
        _fileName = pickedImage.name;
        _convertImageToBase64();
      } else {
        print('No Image File Found');
      }
    });
  }

  void _convertImageToBase64() {
    if (_image != null) {
      File imageFile = File(_image!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Add Product",
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
                ),
              ),
              backgroundColor: ColorConstants.primaryColor,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 10.sp),
              _image != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.Grey500.withOpacity(0.5),
                        blurRadius: 8.sp,
                        spreadRadius: 4.sp,
                        offset: Offset(2.sp, 2.sp),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Image.file(
                      File(_image!.path),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
                  : GestureDetector(
                onTap: getImage,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.Grey500, width: 1.5.sp),
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo),
                          SizedBox(height: 4.sp),
                          Text(
                            "Upload Image",
                            style: TextStyle(color: ColorConstants.blackColor, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 27.sp),
                  Text(
                    'Product Name',
                    style: TextStyle(color: ColorConstants.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 6.sp),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xff6e8aef),
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: TextStyle(color: ColorConstants.Grey500, fontWeight: FontWeight.w300),
                    labelStyle: TextStyle(color: Colors.black),
                    errorStyle: TextStyle(color: Colors.red),
                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.Grey500, width: 1)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade700, width: 1)),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.Grey500, width: 1)),
                  ),
                ),
              ),
              SizedBox(height: 15.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 27.sp),
                  Text(
                    'Price',
                    style: TextStyle(color: ColorConstants.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 6.sp),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xff6e8aef),
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color: ColorConstants.Grey500, fontWeight: FontWeight.w300),
                    labelStyle: TextStyle(color: Colors.black),
                    errorStyle: TextStyle(color: Colors.red),
                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.Grey500, width: 1)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade700, width: 1)),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstants.Grey500, width: 1)),
                  ),
                ),
              ),
              SizedBox(height: 100.sp),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String price = priceController.text.trim();
                    if (name.isNotEmpty && price.isNotEmpty && _base64Image != null) {
                      setState(() {
                        nameController.text = '';
                        priceController.text = '';
                        products.add(ProductData(name: name, price: price, image: _base64Image));
                      });
                      saveIntoSp();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListPage()));
                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: ColorConstants.primaryColor,
                            title: Text('Missing Product Details'),
                            content: Text('Please Enter the Product Details'),
                            actions: [
                              // TextButton(
                              //   child: Text('Cancel'),
                              //   onPressed: () {
                              //     Navigator.of(context).pop(); // Close the dialog
                              //   },
                              // ),
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  // Perform some action
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );

                      // AlertDialog(
                      //   title: Text('sdghjkl'),
                      //   content: Text('dghjkl'),
                      //   icon: Icon(Icons.add),
                      // );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Please enter both product name and price'),
                      //   ),
                      // );
                      return;
                    }
                  },
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color(0xfffefffe),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0065fe),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: TextStyle(
                    color: ColorConstants.Grey500,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
