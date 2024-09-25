import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/feature/bloc/login/login_event.dart';
import 'package:todo_app/feature/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final SharedPreferenceHelper _pref;

  LoginBloc(this._pref): super(LoginInitial()){
    on<LoginUser>(_onLoginUser);
  }

  void _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final email = _pref.getString(Constant.email);
      final password = _pref.getString(Constant.password);
      if(email == event.email && password == event.password){
        _pref.setBool(Constant.isVerified, true);
        emit(LoginSuccess());
      }else{
        emit(const LoginFailure('User data not the same'));
      }
    }catch(e){
        emit(const LoginFailure("An error occurred"));
    }
  }

}



























