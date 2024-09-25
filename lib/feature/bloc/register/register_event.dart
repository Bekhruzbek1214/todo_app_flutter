import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterUser(this.fullName, this.email, this.password, this.confirmPassword);

  @override
  // TODO: implement props
  List<Object?> get props => [fullName, email, password, confirmPassword];

}
























