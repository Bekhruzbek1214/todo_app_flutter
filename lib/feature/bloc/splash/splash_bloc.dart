import 'package:todo_app/core/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/feature/bloc/splash/splash_event.dart';
import 'package:todo_app/feature/bloc/splash/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{
   final SharedPreferenceHelper _pref;

   SplashBloc(this._pref): super(SplashInitial()){
     on<CheckVerificationStatus>((event, emit) async{
       emit(SplashLoading());
       await Future.delayed(const Duration(seconds: 1));
       var bool = _pref.getBoolean(Constant.isVerified);
       if(bool == null || !bool){
         emit(SplashAuthenticated());
       }else{
         emit(SplashAuthenticated());
       }
     });
   }

}