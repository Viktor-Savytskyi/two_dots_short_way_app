import 'dart:collection';
import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';

class PathFinder {
 const  PathFinder();

  List<GridPoint>? findPath({required PathTask task}) {
    final queue = Queue<GridPoint>.of([task.start]);
    final visited =  <GridPoint>{task.start};
    final cameFrom = <GridPoint, GridPoint>{};

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current == task.end) return _buildPath(cameFrom: cameFrom, end: task.end);

      for (final neighbor in current.neighbors()) {
        if (!task.isAvailable(neighbor) || visited.contains(neighbor)) continue;
          visited.add(neighbor);
          cameFrom[neighbor] = current;
          queue.add(neighbor);
      }
    }
    return null;
  }

  List<GridPoint> _buildPath({required Map<GridPoint, GridPoint> cameFrom, required GridPoint end}) {
    var point = end;
    final path = [point];
    while (cameFrom.containsKey(point)) {
      point = cameFrom[point]!;
      path.add(point);
    }
    return path.reversed.toList();
 }
}