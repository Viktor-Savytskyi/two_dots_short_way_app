import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';

class PathResult {
  const PathResult({required this.task, required this.steps});

  final PathTask task;
  final List<GridPoint>? steps;

  String? getPath() {
    return steps
        ?.map((point) => '(${point.x},${point.y})')
        .join('->');
  }

  Map<String, dynamic> toJson() => {
    'id': task.id,
    'result': {
      'steps': steps?.map((point) => point.toJson()).toList(),
      'path': getPath(),
    },
  };
}