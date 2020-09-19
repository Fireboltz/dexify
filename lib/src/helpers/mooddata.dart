import 'package:charts_flutter/flutter.dart' as charts;

class MoodData {
  String date;
  int moodno;
  final charts.Color barColor;

  MoodData(this.moodno, this.date, this.barColor);
}
