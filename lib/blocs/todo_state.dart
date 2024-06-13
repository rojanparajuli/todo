import 'package:equatable/equatable.dart';
import 'package:todo_bloc/model/todo_model.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({this.todos = const []});

  @override
  List<Object> get props => [todos];
}
