import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/internal/path_result.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import 'package:two_dots_short_way_app/widgets/grid_cell.dart';
import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';
import 'dart:math';

class TaskFieldScreen extends StatefulWidget {
  const TaskFieldScreen({
    super.key,
    required this.result,
  });

  final PathResult result;

  @override
  State<TaskFieldScreen> createState() => _TaskFieldScreenState();
}

class _TaskFieldScreenState extends State<TaskFieldScreen> {
  static const double _minCellSize = 40;

  @override
  Widget build(BuildContext context) {
    final size = widget.result.task.size;
    final pathPoints = widget.result.steps?.toSet() ?? <GridPoint>{};

    return AppScaffold(
      title: 'Preview screen',
      padding: .zero,
      body: Column(
        children: [
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cellSize = max(constraints.maxWidth / size, _minCellSize);
                final gridSide = cellSize * size;

                return SizedBox(
                  width: constraints.maxWidth,
                  height: min(gridSide, constraints.maxHeight),
                  child: InteractiveViewer(
                    constrained: false,
                    minScale: 0.1,
                    maxScale: 4,
                    child: SizedBox(
                      width: gridSide,
                      height: gridSide,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size,
                        ),
                        itemCount: size * size,
                        itemBuilder: (context, index) {
                          final x = index % size;
                          final y = index ~/ size;
                          final baseType = widget.result.task.typeOfCell(x: x, y: y);
                          final isOnPath = pathPoints.contains(GridPoint(x: x, y: y));
                          return GridCell(
                            x: x,
                            y: y,
                            type: baseType == .empty && isOnPath ? .path : baseType,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.result.getPath() ?? 'No path found',
            style: TextStyle(fontSize: 14, fontWeight: .w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}