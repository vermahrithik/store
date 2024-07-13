import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:store/bloc/BasicBloc.dart';
import 'package:store/utils/ApiConstants.dart';
import 'package:store/utils/dialogs/ToastUtil.dart';

class BasicException implements Exception {
  BasicException(error) {
    print(error);
  }
}

class BasicProvider {
  BasicProvider(this.client) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  final Dio client;

  String apiUrl = "";

  //SendOTPEvent

  Future<Response?> loginEvent(LoginEvent event) async {
    apiUrl = ApiConstants.BASE_URL + ApiConstants.LOGIN;

    Map<String, dynamic> param = {
      'email': event.email,
      'password': event.password,
    };

    try {
      Response response = await client.post(apiUrl, data: param);
      print(response);
      return response;
    } catch (error) {
      return null;
    }
  }

}
