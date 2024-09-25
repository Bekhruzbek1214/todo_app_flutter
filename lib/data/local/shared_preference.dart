import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/constant.dart';

import '../model/todo_data.dart';



class SharedPreferenceHelper{
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<TodoData>> loadTodoList() async {
    final todoListJSON = _prefs.getString(Constant.todoList) ?? "[]";
    try{
      final decodedTodoList = jsonDecode(todoListJSON) as List<dynamic>;
      return decodedTodoList.map((todo) => TodoData.fromJson(todo)).toList();
    }catch(e){
      return [];
    }
  }
  
  Future<void> addTodo(TodoData todoData) async {
     final todoList = await loadTodoList();
     todoList.add(todoData);
     final updateTodoListJSON = jsonEncode(todoList.map((list) => list.toJson()).toList());
     await _prefs.setString(Constant.todoList, updateTodoListJSON);
  }
  Future<void> updateTodoListAtIndex(int index, TodoData updateData) async {
    final todoList = await loadTodoList();
    if(index >= 0 && index <  todoList.length){
      todoList[index] = updateData;
      final updatedTodoListJSON = jsonEncode(todoList.map((list) => list.toJson()).toList());
      await _prefs.setString(Constant.todoList, updatedTodoListJSON);
    }
  }
  Future<void> deleteTodoListAtIndex(int index) async {
    final todoList = await loadTodoList();
    if(index >= 0 && index < todoList.length){
      todoList.removeAt(index);
      final updateContactsJSON = jsonEncode(todoList.map((list) => list.toJson()).toList());
      await _prefs.setString(Constant.todoList, updateContactsJSON);
    }
  }
  Future<void> deleteTodoListItem(index, TodoData data) async {
    final todoList = await loadTodoList();
    if(index >= 0 && index < todoList.length){
      todoList.remove(data);
      final updateTodoListJSON = jsonEncode(todoList.map((list) => list.toJson()).toList());
      await _prefs.setString(Constant.todoList, updateTodoListJSON);
    }
  }
  Future<void> setString(String key, String value) async{
    _prefs.setString(key, value);
  }
  Future<void> setBool(String key, bool value) async {
    _prefs.setBool(key, value);
  }
  String? getString(String key) {
    return _prefs.getString(key);
  }
  bool? getBoolean(String key){
    return _prefs.getBool(key);
  }
  Future<void> delete(){
    return _prefs.clear();
  }
}





















