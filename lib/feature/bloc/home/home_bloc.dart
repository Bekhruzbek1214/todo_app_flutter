import 'package:todo_app/core/constant.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/data/local/sqflite/db_helper.dart';
import 'package:todo_app/feature/bloc/home/home_event.dart';
import 'package:todo_app/feature/bloc/home/home_state.dart';
import 'package:bloc/bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final SharedPreferenceHelper _pref;
  final MyDatabaseHelper _database;


  HomeBloc(this._pref, this._database):super(HomeInitial()){
    on<LoadTodoData>(_onLoadTodoList);
    on<DeleteTodoData>(_onDeleteTodo);
    on<LogOutUser>(_onLogoutUser);
    on<UnregisterUser>(_onUnregisterUser);
  }


  void _onLoadTodoList(LoadTodoData event, Emitter<HomeState> emit) async {
      emit(HomeLoading());
      try{
        final todoList = await _database.getAllTodoData();
        emit(HomeLoaded(todoList));
      }catch(error){
        emit(HomeError(error.toString()));
      }
  }
  void _onDeleteTodo(DeleteTodoData event, Emitter<HomeState> emit) async {
    try{
      _database.deleteTodoData(event.todoId);
      add(LoadTodoData());
    }catch(error){
      emit(HomeError(error.toString()));
    }
  }
  void _onLogoutUser(LogOutUser event, Emitter<HomeState> emit) async {
    await _pref.setBool(Constant.isVerified, false);
  }
  void _onUnregisterUser(UnregisterUser event, Emitter<HomeState> state) async {
    await _pref.delete();
    //navigate to login screen
  }
}