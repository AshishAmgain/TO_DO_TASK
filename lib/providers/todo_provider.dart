import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_model.dart';

class TodoState {
  final List<Todo> todos;
  final bool isLoading;

  TodoState({required this.todos, this.isLoading = false});

  TodoState copyWith({List<Todo>? todos, bool? isLoading}) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TodoController extends StateNotifier<TodoState> {
  TodoController() : super(TodoState(todos: []));

  void addTodo(Todo todo) {
    state = state.copyWith(todos: [...state.todos, todo]);
  }

  void updateTodo(Todo updatedTodo) {
    state = state.copyWith(
      todos: state.todos.map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo).toList(),
    );
  }

  void updatePinned(Todo updatedTodo) {
    state = state.copyWith(
      todos: state.todos.map((todo) => todo.id == updatedTodo.id ? updatedTodo.copyWith(isPinned: !updatedTodo.isPinned) : todo).toList(),
    );
  }

  void toggleComplete(Todo updatedTodo) {
    state = state.copyWith(
      todos: state.todos.map((todo) => todo.id == updatedTodo.id ? updatedTodo.copyWith(isCompleted: !updatedTodo.isCompleted) : todo).toList(),
    );
  }
}

final todoControllerProvider = StateNotifierProvider<TodoController, TodoState>((ref) {
  return TodoController();
});

final allTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoControllerProvider).todos;
  return todos;
});

final activeTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoControllerProvider).todos;
  return todos.where((todo) => !todo.isCompleted).toList();
});

final pinnedTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoControllerProvider).todos;
  return todos.where((todo) => todo.isPinned).toList();
});

final completedTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoControllerProvider).todos;
  return todos.where((todo) => todo.isCompleted).toList();
});
