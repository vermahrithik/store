import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:store/utils/dialogs/ToastUtil.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/repository/BasicRepository.dart';
import 'package:store/utils/ColorConstants.dart';
import 'package:store/utils/dialogs/DialogUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/UserData.dart';

part 'BasicEvent.dart';
part 'BasicState.dart';

class BasicBloc extends Bloc<BasicEvent, BasicState> {
  BasicRepository repository;

  BasicBloc(this.repository) : super(const BasicInitialState(version: 0)) {

    on<LoginEvent>(_handleLoginEvent, transformer: sequential());

  }

  /// Verification Event Handler :

  // void _handleLoginEvent(LoginEvent event,
  //     Emitter<BasicState> emit) async {
  //
  //   late String newToken;
  //
  //   DialogUtil.showProgressDialog(
  //       "", event.context, ColorConstants.primaryColorTwo);
  //   await Future.delayed(Duration(seconds: 1));
  //   Response? serverAPIResponseDto = await repository.loginEvent(event);
  //   DialogUtil.dismissProgressDialog(event.context);
  //   if (serverAPIResponseDto != null) {
  //     if (serverAPIResponseDto.data["error"].toString() == "user not found") {
  //
  //       ToastUtil.showToast("Please Enter Credentials Correctly");
  //
  //     } else if (serverAPIResponseDto.data["token"].toString() != ""){
  //       print(serverAPIResponseDto.data);
  //       Map<String, dynamic> dataDto =
  //       serverAPIResponseDto.data as Map<String, dynamic>;
  //       UserData usermodal = UserData.fromJson(dataDto);
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString("usermodal", jsonEncode(usermodal));
  //
  //       if (jsonDecode(prefs.getString("usermodal").toString()).toString() !=
  //           "null") {
  //         Map<String, dynamic> jsonData =
  //         jsonDecode(prefs.getString('usermodal').toString());
  //         UserData usermodal = UserData.fromJson(jsonData);
  //
  //         newToken = usermodal.token;
  //         print(newToken);
  //       }
  //       LoginCompleteState loginCompleteState =
  //       LoginCompleteState(
  //           context: event.context, version: state.version + 2);
  //       emit(loginCompleteState);
  //     }else{
  //       ToastUtil.showToast('Some Error Has Occured');
  //     }
  //   }
  // }

  void _handleLoginEvent(LoginEvent event, Emitter<BasicState> emit) async {
    late String newToken;

    DialogUtil.showProgressDialog(
        "", event.context, ColorConstants.primaryColorTwo);
    await Future.delayed(Duration(seconds: 1));

    Response? serverAPIResponseDto = await repository.loginEvent(event);
    DialogUtil.dismissProgressDialog(event.context);
    if (serverAPIResponseDto != null) {
      print("Server response: ${serverAPIResponseDto.data}");
      if (serverAPIResponseDto.data.containsKey("error")) {
        String error = serverAPIResponseDto.data["error"];
        print("Error from server: $error");
        ToastUtil.showToast("Please Enter Credentials Correctly");
      } else if (serverAPIResponseDto.data.containsKey("token")) {
        String token = serverAPIResponseDto.data["token"];
        print("Token received: $token");

        Map<String, dynamic> dataDto = serverAPIResponseDto.data as Map<String, dynamic>;
        UserData usermodal = UserData.fromJson(dataDto);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("usermodal", jsonEncode(usermodal));

        String? storedUserModal = prefs.getString("usermodal");
        if (storedUserModal != null && storedUserModal.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(storedUserModal);
          UserData usermodal = UserData.fromJson(jsonData);
          newToken = usermodal.token;
          print("New token: $newToken");
        }

        LoginCompleteState loginCompleteState = LoginCompleteState(
            context: event.context, version: state.version + 2);
        emit(loginCompleteState);
      } else {
        ToastUtil.showToast('Some Error Has Occurred');
      }
    } else {
      ToastUtil.showToast('This User Not Exists ,\nPlease Enter Credentials Correctly');
    }
  }

  void _handleAddProductEvent(LoginEvent event, Emitter<BasicState> emit) async {
    late String newToken;

    DialogUtil.showProgressDialog(
        "", event.context, ColorConstants.primaryColorTwo);
    await Future.delayed(Duration(seconds: 1));

    Response? serverAPIResponseDto = await repository.loginEvent(event);
    DialogUtil.dismissProgressDialog(event.context);
    if (serverAPIResponseDto != null) {
      print("Server response: ${serverAPIResponseDto.data}");
      if (serverAPIResponseDto.data.containsKey("error")) {
        String error = serverAPIResponseDto.data["error"];
        print("Error from server: $error");
        ToastUtil.showToast("Please Enter Credentials Correctly");
      } else if (serverAPIResponseDto.data.containsKey("token")) {
        String token = serverAPIResponseDto.data["token"];
        print("Token received: $token");

        Map<String, dynamic> dataDto = serverAPIResponseDto.data as Map<String, dynamic>;
        UserData usermodal = UserData.fromJson(dataDto);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("usermodal", jsonEncode(usermodal));

        String? storedUserModal = prefs.getString("usermodal");
        if (storedUserModal != null && storedUserModal.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(storedUserModal);
          UserData usermodal = UserData.fromJson(jsonData);
          newToken = usermodal.token;
          print("New token: $newToken");
        }

        LoginCompleteState loginCompleteState = LoginCompleteState(
            context: event.context, version: state.version + 2);
        emit(loginCompleteState);
      } else {
        ToastUtil.showToast('Some Error Has Occurred');
      }
    } else {
      ToastUtil.showToast('This User Not Exists ,\nPlease Enter Credentials Correctly');
    }
  }


}