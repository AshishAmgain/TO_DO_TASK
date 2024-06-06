import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_provider.dart';

final remainingTodoProvider = Provider<int>((ref) {
  final todos = ref.watch(todoControllerProvider).todos;
  return todos.where((todo) => !todo.isCompleted).length;
});
