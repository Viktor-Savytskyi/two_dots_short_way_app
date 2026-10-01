import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/ui/cell_type.dart';

extension CellTypeColors on CellType {
  Color get backgroundColor => switch(this) {
    .empty => const Color(0xFFFFFFFF),
    .blocked => const Color(0xFF000000),
    .start => const Color(0xFF64FFDA),
    .finish => const Color(0xFF009688),
    .path => const Color(0xFF4CAF50),
  };

  Color get textColor => switch (this) {
    .blocked || .finish => Colors.white,
    _ => Colors.black,
  };
}