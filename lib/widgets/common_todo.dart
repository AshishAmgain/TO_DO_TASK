import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

class CommonTodo extends ConsumerWidget {
  const CommonTodo(this.todoProvider,
      {super.key, required this.color, required this.iconColor});

  final Provider<List<Todo>> todoProvider;
  final Color? color;
  final Color iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 70,
          child: InkWell(
            onTap: () {
              ref
                  .read(todoControllerProvider.notifier)
                  .toggleComplete(todos[index]);
            },
            child: ListTile(
              leading: Checkbox(
                value: todos[index].isCompleted,
                onChanged: (value) {
                  ref
                      .read(todoControllerProvider.notifier)
                      .toggleComplete(todos[index]);
                },
                activeColor: iconColor,
              ),
              title: Text(todos[index].title),
              trailing: IconButton(
                onPressed: () {
                  ref
                      .read(todoControllerProvider.notifier)
                      .updatePinned(todos[index]);
                },
                icon: Icon(
                  todos[index].isPinned ? Icons.star : Icons.star_border,
                  color: todos[index].isPinned ? iconColor : Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
