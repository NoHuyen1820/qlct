import 'dart:ui';

class PieSectionData {
  String name; // category
  double percent; // sum amount
  final Color color; // color
  PieSectionData(
      {required this.name, required this.percent, required this.color});
}
