import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/extensions/cell_type_colors.dart';
import 'package:two_dots_short_way_app/models/ui/cell_type.dart';

class GridCell extends StatelessWidget {
GridCell({
  super.key,
  required this.x,
  required this.y,
  required this.type,
});

final int x;
final int y;
final CellType type;

@override
  Widget build(BuildContext context) {
 return Container(
   decoration: BoxDecoration(
     color: type.backgroundColor,
     border: Border.all(color: Colors.black, width: 0.5)
   ),
     child: Center(
       child: Text(
         '($x, $y)',
         style: TextStyle(fontSize: 12, color: type.textColor),
       ),
     ),
 );
  }
}