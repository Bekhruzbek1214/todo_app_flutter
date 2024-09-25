part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}
class EditData extends EditEvent {
  final TodoData editData;

  EditData({required this.editData});

}