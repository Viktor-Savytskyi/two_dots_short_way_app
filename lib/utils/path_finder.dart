import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';

class PathFinder {
   PathFinder({
    required this.field,
    required this.start,
    required this.end,
  });

  final List<String> field;
  final GridPoint start;
  final GridPoint end;

}