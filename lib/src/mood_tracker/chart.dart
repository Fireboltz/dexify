import 'package:flutter/material.dart';
import 'package:dexify/src/helpers/mooddata.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dexify/src/models/moodcard.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  List<CircleAvatar> colors = [
    CircleAvatar(backgroundColor: Colors.red),
    CircleAvatar(backgroundColor: Colors.black),
    CircleAvatar(backgroundColor: Colors.pink),
    CircleAvatar(backgroundColor: Colors.purple),
    CircleAvatar(backgroundColor: Colors.green),
    CircleAvatar(backgroundColor: Colors.blue)
  ];

  List<String> colornames = ['Red', 'Black', 'Pink', 'Purple', 'Green', 'Blue'];
  double a = 0;
  double b = 0;
  double c = 0;
  double d = 0;
  double e = 0;
  double f = 0;
  double g = 0;
  double h = 0;
  double i = 0;
  double j = 0;
  double k = 0;
  double l = 0;
  double m = 0;
  double n = 0;
  double o = 0;
  double p = 0;
  double q = 0;
  double r = 0;
  double s = 0;

  Map<String, double> dataMap = Map();
  Map<String, double> dataMap2 = Map();

  void initState() {
    super.initState();
    Provider.of<MoodCard>(context, listen: false).data.forEach((element) {
      if (element.moodno == 1)
        a = a + 1;
      else if (element.moodno == 2)
        b = b + 1;
      else if (element.moodno == 3)
        c = c + 1;
      else if (element.moodno == 4)
        d = d + 1;
      else if (element.moodno == 5)
        e = e + 1;
      else
        f = f + 1;
    });

    Provider.of<MoodCard>(context, listen: false).actiname.forEach((element) {
      if (element == 'Sports')
        g = g + 1;
      else if (element == 'Sleep')
        h = h + 1;
      else if (element == 'Shop')
        i = i + 1;
      else if (element == 'Relax')
        j = j + 1;
      else if (element == 'Read')
        k = k + 1;
      else if (element == 'Movies')
        l = l + 1;
      else if (element == 'Gaming')
        m = m + 1;
      else if (element == 'Friends')
        n = n + 1;
      else if (element == 'Family')
        o = o + 1;
      else if (element == 'Excercise')
        p = p + 1;
      else if (element == 'Eat')
        q = q + 1;
      else if (element == 'Date')
        r = r + 1;
      else if (element == 'Clean') s = s + 1;
    });

    dataMap.putIfAbsent("Happy", () => b);
    dataMap.putIfAbsent("Sad", () => c);
    dataMap.putIfAbsent("Angry", () => a);
    dataMap.putIfAbsent("Surprised", () => d);
    dataMap.putIfAbsent("Scared", () => f);
    dataMap.putIfAbsent("Loving", () => e);
    dataMap2.putIfAbsent('Sports', () => g);
    dataMap2.putIfAbsent('Sleep', () => h);
    dataMap2.putIfAbsent('Shop', () => i);
    dataMap2.putIfAbsent('Relax', () => j);
    dataMap2.putIfAbsent('Read', () => k);
    dataMap2.putIfAbsent('Movies', () => l);
    dataMap2.putIfAbsent('Gaming', () => m);
    dataMap2.putIfAbsent('Friends', () => n);
    dataMap2.putIfAbsent('Family', () => o);
    dataMap2.putIfAbsent('Excercise', () => p);
    dataMap2.putIfAbsent('Eat', () => q);
    dataMap2.putIfAbsent('Date', () => r);
    dataMap2.putIfAbsent('Clean', () => s);
  }

  @override
  Widget build(BuildContext context) {
    List<MoodData> data = Provider.of<MoodCard>(context, listen: true).data;
    List<charts.Series<MoodData, String>> series = [
      charts.Series(
        id: 'Moods',
        data: data,
        domainFn: (MoodData series, _) => series.date,
        measureFn: (MoodData series, _) => series.moodno,
        colorFn: (MoodData series, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      )
    ];

    WidgetsBinding.instance.addPostFrameCallback((_){
      if ((b + e) > a && (b + e) > c && (b + e) > d && (b + e) > f) {
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text('Good going!'),
                    content: Text('Looks like you\'ve been happy for most of the time. Keep it up!!'),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      } else {
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text('Hey cheer up!!'),
                    content: Text('Turn that frown up side down!! Be positive.'),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      }
    });

    return Scaffold(
      appBar: AppBar(
          title: Text('Mood Graphs'), backgroundColor: Color(0xFF2633C5)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              child: Card(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Column(
                      children: <Widget>[
                        Text(
                          ' ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Moods list ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '1- ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '2- ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '3- ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '4- ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '5- ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '6- ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(width: 7),
                    Column(children: <Widget>[
                      Text(
                        ' ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Angry',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Happy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sad',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Surprised',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Loving',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Scared',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ])
                  ],
                ),
              ),
            ),
            SizedBox(width: 7),
            Divider(),
            SizedBox(width: 7),
            Center(
                child: Text(
                  'Days',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
            ),
            SizedBox(width: 7),
            Center(
              child: Container(
                height: 200,
                width: 300,
                child: charts.BarChart(
                  series,
                  animate: true,
                ),
              ),
            ),
            SizedBox(width: 7),
            Divider(),
            SizedBox(width: 7),
            Center(
              child: Text(
                'Chart representing your mood',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
            SizedBox(width: 7),
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 2.7,
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValuesOutside: false,
              chartValueBackgroundColor: Colors.grey[200],
              showLegends: true,
              legendPosition: LegendPosition.right,
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: defaultChartValueStyle.copyWith(
                color: Colors.blueGrey[900].withOpacity(0.9),
              ),
              chartType: ChartType.disc,
            ),
            SizedBox(width: 7),
            Divider(),
            SizedBox(width: 7),
            Center(
                child: Text(
                  'Chart representing your activities',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
            ),
            SizedBox(width: 7),
            Container(
              height: 330,
              width: 400,
              child: PieChart(
                dataMap: dataMap2,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                showChartValuesInPercentage: true,
                showChartValues: true,
                showChartValuesOutside: false,
                chartValueBackgroundColor: Colors.grey[200],
                showLegends: true,
                legendPosition: LegendPosition.right,
                decimalPlaces: 1,
                showChartValueLabel: true,
                initialAngle: 0,
                chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.blueGrey[900].withOpacity(0.9),
                ),
                chartType: ChartType.disc,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
