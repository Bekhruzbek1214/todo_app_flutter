import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/data/local/sqflite/db_helper.dart';
import 'package:todo_app/data/model/todo_data.dart';


part 'edit_event.dart';
part 'edit_state.dart';


class EditBloc extends Bloc<EditEvent, EditState>{
   final MyDatabaseHelper _database;

   EditBloc(this._database):super(EditInitial()){
     on<EditData>((event, emit){
       emit(EditLoading());
       _database.updateTodoData(event.editData);
       emit(EditSuccess());
     });
   }
}



















