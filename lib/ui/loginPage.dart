import 'dart:ui';

import 'package:store/ui/homePage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BasicBloc.dart';
import '../repository/BasicRepository.dart';

import 'package:store/utils/ColorConstants.dart';
import '../utils/dialogs/toastUtil.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => BasicBloc(BasicRepository(Dio())),
      ),
    ], child: LoginPageStateful()));
  }
}

class LoginPageStateful extends StatefulWidget {
  const LoginPageStateful({super.key});

  @override
  State<LoginPageStateful> createState() => _LoginPageStatefulState();
}

class _LoginPageStatefulState extends State<LoginPageStateful> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void handleVerification() {
    setState(() {
      //otpSent = true;
    });
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible,
      // false = user must tap button, true = tap outside dialog
      builder: (context) {
        return AlertDialog(
          title: Text('title'),
          content: Text('dialogBody'),
          actions: <Widget>[
            TextButton(
              child: Text('buttonText'),
              onPressed: () {
                // Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: BlocListener<BasicBloc, BasicState>(
        listener: (context, state) {
          if (state is LoginCompleteState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProductListPage()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/logo.jpg',
                        // height: 500,
                        width: deviceWidth * 0.8,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w700),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Text(
                            '@',
                            style: TextStyle(
                                color: ColorConstants.Grey500, fontSize: 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              controller: emailController,
                              cursorColor: Color(0xff6e8aef),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email ID',
                                hintStyle: TextStyle(
                                    color: ColorConstants.Grey500,
                                    fontWeight: FontWeight.w300),
                                labelStyle:
                                    TextStyle(color: ColorConstants.Grey500),
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.Grey500,
                                      width:
                                          1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade700,
                                      width:
                                          1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.Grey500,
                                      width:
                                          1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            color: ColorConstants.Grey500,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff6e8aef),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: ColorConstants.Grey500,
                                    fontWeight: FontWeight.w300),
                                labelStyle: TextStyle(color: Colors.black),
                                errorStyle: TextStyle(color: Colors.red),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabled: true,
                                // prefixIcon: Icon(Icons.text_fields),
                                suffixIcon: togglePassword(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.Grey500, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade700, width: 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.Grey500, width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Color(0xff0065fa),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ElevatedButton(
                          onPressed: checkValidation,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Color(0xfffefffe),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0065fe),
                            fixedSize: Size(deviceWidth * 0.75, 30.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(width: ,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.002,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(
                            width: 8,
                            height: 0,
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                                color: ColorConstants.Grey500, fontSize: 15),
                          ),
                          SizedBox(
                            width: 8,
                            height: 0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.002,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/google.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 45,
                              ),
                              Text(
                                'Login with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff768291),
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff0f4f4),
                            fixedSize: Size(deviceWidth * 0.75, 30.0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New to Logistics?',
                                style: TextStyle(
                                    color: ColorConstants.Grey500,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Register',
                                style: TextStyle(
                                    color: Color(0xff0065fe),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkValidation() {
    if (emailController.text.isEmpty) {
      ToastUtil.showToast("Please Enter Email");
    } else if (!isValidEmail(emailController.text)) {
      ToastUtil.showToast("Please Enter a Valid Email");
    }
    else if (passwordController.text.isEmpty) {
      ToastUtil.showToast("Please Enter Password");
    }
    else if (passwordController.text.length <6 || passwordController.text.length >6) {
      ToastUtil.showToast("Please Enter Password Correctly");
    }else if(passwordController.text.length == 6 && passwordController.text !="pistol"){
      ToastUtil.showToast("Please Enter Password Correctly");
    }
    else {
        context.read<BasicBloc>().add(LoginEvent(
        context: context,
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }



  Widget togglePassword(){
    return IconButton(
        onPressed: (){
          setState(() {
          _obscureText = !_obscureText;
          });
        },
        icon: _obscureText ? Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined),
        color: ColorConstants.Grey500,
    );
  }



}
