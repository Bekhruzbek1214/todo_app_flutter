import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState{}
class RegisterLoading extends RegisterState{}
class RegisterSuccess extends RegisterState{}
class RegisterFailure extends RegisterState{
  final String message;

  const RegisterFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}




















