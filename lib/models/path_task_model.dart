import 'package:two_dots_short_way_app/models/grid_point_model.dart';

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

  factory PathTask.fromJson(Map<String, dynamic> json) {
    return PathTask(
        id: json['id'] as String,
      field: List<String>.from(json['field'] as List),
      start: GridPoint.fromJson(json['start'] as Map<String, dynamic>),
      end: GridPoint.fromJson(json['end'] as Map<String, dynamic>),
    );
  }
}

