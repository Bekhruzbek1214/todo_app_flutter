import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SplashInitial extends SplashState{}
class SplashLoading extends  SplashState{}
class SplashAuthenticated extends SplashState{}
class SplashUnauthenticated extends SplashState{}