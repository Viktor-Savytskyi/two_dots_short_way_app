import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';
import 'package:two_dots_short_way_app/models/ui/cell_type.dart';

class PathTask {
  const PathTask({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  final String id;
  final List<String> field;
  final GridPoint start;
  final GridPoint end;

  int get size => field.length;

  CellType typeOfCell({required int x, required int y}) {
    if (start.x == x && start.y == y) return .start;
    if (end.x == x && end.y == y) return .finish;
    final symbol = field[y][x];
    return symbol == 'X' ? .blocked : .empty;
  }

  bool _isInsideField(GridPoint point) {
    return (
        point.x < size
        && point.y < size
        && point.x >= 0
        && point.y >= 0
    );
  }

  bool isAvailable(GridPoint point) {
    if (!_isInsideField(point)) return false;
    final cellType = typeOfCell(x: point.x, y: point.y);
    return cellType != .blocked;
  }

  factory PathTask.fromJson(Map<String, dynamic> json) {
    return PathTask(
      id: json['id'] as String,
      field: List<String>.from(json['field'] as List),
      start: GridPoint.fromJson(json['start'] as Map<String, dynamic>),
      end: GridPoint.fromJson(json['end'] as Map<String, dynamic>),
    );
  }
}

