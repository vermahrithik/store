import 'package:dio/dio.dart';
import 'package:store/bloc/BasicBloc.dart';
import '../dataprovider/BasicProvider.dart';

class BasicRepository {
  final Dio client;

  late final BasicProvider provider;

  BasicRepository(this.client) {
    provider = BasicProvider(client);
  }

  Future<Response?> loginEvent(LoginEvent event) =>
      provider.loginEvent(event);

}
