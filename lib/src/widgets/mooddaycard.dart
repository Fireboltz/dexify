import 'package:flutter/material.dart';
import 'package:dexify/src/helpers/db_helper.dart';
import 'package:dexify/src/models/moodcard.dart';
import 'package:provider/provider.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 5), child: Text("Deleting entry...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class MoodDay extends StatefulWidget {
  String datetime;
  String mood;
  String image;
  List<String> a;
  List<String> b;

  MoodDay(this.image, this.datetime, this.mood, this.a, this.b);

  @override
  _MoodDayState createState() => _MoodDayState();
}

class _MoodDayState extends State<MoodDay> {
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 125,
        width: 80,
        child: Card(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(widget.image),
                  height: 65,
                  width: 65,
                ),
                Text(
                  widget.mood,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(width: 10),
                Text(
                  widget.datetime ?? '',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(width: 30),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      Provider.of<MoodCard>(context, listen: false).isloading =
                          true;
                      await Provider.of<MoodCard>(context, listen: false)
                          .deletePlaces(widget.datetime);
                      Provider.of<MoodCard>(context, listen: false).isloading =
                          false;
                    })
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 65),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.a.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Image.asset(widget.a[index]),
                            SizedBox(width: 25)
                          ],
                        );
                      }),
                ],
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 65),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.b.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Text(
                              widget.b[index] ?? 'nothinng',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(width: 10)
                          ],
                        );
                      }),
                ],
              ),
            ),
          ]),
        ));
  }
}
