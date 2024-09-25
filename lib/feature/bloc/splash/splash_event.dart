import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable{
  const SplashEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckVerificationStatus extends SplashEvent{}