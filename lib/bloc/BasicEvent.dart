part of 'BasicBloc.dart';

abstract class BasicEvent extends Equatable {
  const BasicEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends BasicEvent {
  const LoginEvent(
      {required this.context, required this.email, required this.password});

  final String email;
  final String password;
  final BuildContext context;

  @override
  List<Object> get props => [context];
}

class ProductEvent extends BasicEvent {
  const ProductEvent(
      {required this.name,
        required this.price,
        required this.context});

  final String name;
  final String price;
  final BuildContext context;

  @override
  List<Object> get props => [context];
}
