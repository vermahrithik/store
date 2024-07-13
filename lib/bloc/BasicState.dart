part of 'BasicBloc.dart';

class BasicState extends Equatable {
  final int version;
  const BasicState({required this.version});

  @override
  List<Object> get props => [version];
}

class BasicInitialState extends BasicState {
  const BasicInitialState({this.context, required this.version})
      : super(version: version);

  final BuildContext? context;
  @override
  final int version;

  @override
  List<Object> get props => [version];
}

class LoginCompleteState extends BasicState {
  const LoginCompleteState({
    this.context,
    required this.version,
  }) : super(version: version);

  final BuildContext? context;
  @override
  final int version;

  @override
  List<Object> get props => [version];
}
