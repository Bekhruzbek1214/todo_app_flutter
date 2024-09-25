import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends LoginState{}
class LoginLoading extends LoginState{}
class LoginSuccess extends LoginState{}
class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}























