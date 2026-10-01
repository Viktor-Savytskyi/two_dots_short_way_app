import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import 'package:two_dots_short_way_app/widgets/grid_cell.dart';

class TaskFieldScreen extends StatefulWidget {
  const TaskFieldScreen({
  super.key,
  required this.task,
});

final PathTask task;

  @override
  State<TaskFieldScreen> createState() => _TaskFieldScreenState();
}

class _TaskFieldScreenState extends State<TaskFieldScreen> {
  @override
  Widget build(BuildContext context) {
    final size = widget.task.size;

    return AppScaffold(
      title: 'Preview screen',
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size,
              ),
              itemCount: size * size,
              itemBuilder: (context, index) {
                final x = index % size;
                final y = index ~/ size;
                return GridCell(
                  x: x,
                  y: y,
                  type: widget.task.typeOfCell(x: x, y: y),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text('start: (${widget.task.start.x},${widget.task.start.y})  '
              'end: (${widget.task.end.x},${widget.task.end.y})'),
        ],
      ),
    );
  }
}