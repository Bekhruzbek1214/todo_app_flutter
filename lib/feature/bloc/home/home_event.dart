import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadTodoData extends HomeEvent{}
class DeleteTodoData extends HomeEvent{
  final int todoId;

  const DeleteTodoData(this.todoId);

  @override
  // TODO: implement props
  List<Object?> get props => [todoId];
}

class LogOutUser extends HomeEvent{}
class UnregisterUser extends HomeEvent{}
















