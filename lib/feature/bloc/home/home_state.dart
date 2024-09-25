import 'package:equatable/equatable.dart';

import '../../../data/model/todo_data.dart';

abstract class HomeState extends Equatable{
  const HomeState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeInitial extends HomeState{}
class HomeLoading extends HomeState{}
class HomeLoaded extends HomeState{
  final List<TodoData> todoList;

  const HomeLoaded(this.todoList);

  @override
  // TODO: implement props
  List<Object?> get props => [todoList];

}

class HomeError extends HomeState{
  final String message;

  const HomeError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
