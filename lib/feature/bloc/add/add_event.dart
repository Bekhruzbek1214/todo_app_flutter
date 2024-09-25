part of 'add_bloc.dart';

@immutable
sealed class AddEvent{}

class AddTodoData extends AddEvent{
  final TodoData todoData;

  AddTodoData({required this.todoData});
}