import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/data/model/todo_data.dart';
import '../../../data/local/sqflite/db_helper.dart';
part 'add_event.dart';
part 'add_state.dart';


class AddBloc extends Bloc<AddEvent, AddState>{
  final MyDatabaseHelper _database;

  AddBloc(this._database): super(AddInitial()){
    on<AddTodoData>((event, emit){
      _addTodo(event.todoData);
      emit(AddSuccess());
    });
  }

  void _addTodo(TodoData todoData) async {
    await _database.addTodoData(todoData);
  }

}

















