import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_bloc/blocs/todo_event.dart';
import 'package:todo_bloc/blocs/todo_state.dart';
import 'package:todo_bloc/model/todo_model.dart';
import 'dart:convert';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTodo>(_onAddTodo);
    on<ToggleTodo>(_onToggleTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<LoadTodos>(_onLoadTodos);

    // Load todos when the bloc is first created
    add(LoadTodos());
  }

  Future<void> _onAddTodo(
      AddTodo event, Emitter<TodoState> emit) async {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      task: event.task,
    );
    final updatedTodos = List<Todo>.from(state.todos)..add(newTodo);
    emit(TodoState(todos: updatedTodos));
    await _saveTodos(updatedTodos);
  }

  Future<void> _onToggleTodo(
      ToggleTodo event, Emitter<TodoState> emit) async {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return Todo(
          id: todo.id,
          task: todo.task,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    emit(TodoState(todos: updatedTodos));
    await _saveTodos(updatedTodos);
  }

  Future<void> _onRemoveTodo(
      RemoveTodo event, Emitter<TodoState> emit) async {
    final updatedTodos =
        state.todos.where((todo) => todo.id != event.id).toList();
    emit(TodoState(todos: updatedTodos));
    await _saveTodos(updatedTodos);
  }

  Future<void> _onLoadTodos(
      LoadTodos event, Emitter<TodoState> emit) async {
    final todos = await _loadTodos();
    emit(TodoState(todos: todos));
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', todosJson);
  }

  Future<List<Todo>> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos');
    if (todosJson != null) {
      final List<dynamic> decoded = jsonDecode(todosJson) as List<dynamic>;
      return decoded.map((json) => Todo.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }
}
