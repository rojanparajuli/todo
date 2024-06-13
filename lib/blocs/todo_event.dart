import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final String task;

  const AddTodo(this.task);

  @override
  List<Object> get props => [task];
}

class ToggleTodo extends TodoEvent {
  final String id;

  const ToggleTodo(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveTodo extends TodoEvent {
  final String id;

  const RemoveTodo(this.id);

  @override
  List<Object> get props => [id];
}

class LoadTodos extends TodoEvent {}
