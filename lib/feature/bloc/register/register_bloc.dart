import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/feature/bloc/register/register_event.dart';
import 'package:todo_app/feature/bloc/register/register_state.dart';

class  RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final SharedPreferenceHelper _pref;

  RegisterBloc(this._pref):super(RegisterInitial()){
    on<RegisterUser>(_onRegisterUser);
  }

  void _onRegisterUser(RegisterUser event , Emitter<RegisterState> emit) async {
     emit(RegisterLoading());
     try{
       if(event.password != event.confirmPassword){
         emit(const RegisterFailure('Password is not the same'));
         return;
       }
       emit(RegisterLoading());
       await Future.delayed(const Duration(seconds: 1));

       _pref.delete();
       _pref.setString(Constant.email, event.password);
       _pref.setString(Constant.password, event.password);
       _pref.setBool(Constant.isVerified, true);


       emit(RegisterSuccess());

     }catch(error){
        emit(const RegisterFailure('An error occurred'));
     }
  }

}


























