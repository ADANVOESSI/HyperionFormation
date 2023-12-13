import 'package:flutter/material.dart';
import 'package:trello_mobile/domains/taches.dart';

class DraggableTask extends StatelessWidget {
  final Taches task;

  DraggableTask({required this.task});

  @override
  Widget build(BuildContext context) {
    return Draggable<Taches>(
      data: task,
      child: ListTile(title: Text(task.name)),
      feedback: ListTile(title: Text(task.name)),
      childWhenDragging: ListTile(title: Text('En train de glisser...')),
    );
  }
}
