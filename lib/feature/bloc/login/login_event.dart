import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginUser extends LoginEvent {
  final String email;
  final String password;

  const LoginUser(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}