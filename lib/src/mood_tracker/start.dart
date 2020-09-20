import 'package:flutter/material.dart';
import 'package:dexify/src/models/activity.dart';

import 'package:dexify/src/models/mood.dart';
import 'package:dexify/src/models/moodcard.dart';
import 'package:dexify/src/widgets/activity.dart';
import 'package:dexify/src/widgets/moodicon.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  MoodCard moodCard;
  String mood;
  String image;
  String datepicked;
  String timepicked;
  String datetime;
  int currentindex;
  int ontapcount = 0;

  List<Mood> moods = [
    Mood('assets/smile.png', 'Happy', false),
    Mood('assets/sad.png', 'Sad', false),
    Mood('assets/angry.png', 'Angry', false),
    Mood('assets/surprised.png', 'Surprised', false),
    Mood('assets/loving.png', 'Loving', false),
    Mood('assets/scared.png', 'Scared', false)
  ];

  List<Activity> act = [
    Activity('assets/sports.png', 'Sports', false),
    Activity('assets/sleeping.png', 'Sleep', false),
    Activity('assets/shop.png', 'Shop', false),
    Activity('assets/relax.png', 'Relax', false),
    Activity('assets/reading.png', 'Read', false),
    Activity('assets/movies.png', 'Movies', false),
    Activity('assets/gaming.png', 'Gaming', false),
    Activity('assets/friends.png', 'Friends', false),
    Activity('assets/family.png', 'Family', false),
    Activity('assets/excercise.png', 'Excercise', false),
    Activity('assets/eat.png', 'Eat', false),
    Activity('assets/date.png', 'Date', false),
    Activity('assets/clean.png', 'Clean', false)
  ];

  Color colour = Colors.white;

  void initState() {
    super.initState();
  }

  String dateonly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('My Mood Tracker',
                style: TextStyle(
                    fontStyle: FontStyle.normal, fontWeight: FontWeight.bold)),
            backgroundColor: Color(0xFF2633C5),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/home_screen');
                    },
                    child: Icon(Icons.dashboard),
                  )),
            ]),
        body: Container(
          child: Column(children: <Widget>[
            SizedBox(width: 200),
            Row(children: <Widget>[
              SizedBox(width: 70),
              FlatButton.icon(
                  icon: Icon(Icons.date_range),
                  label: Text('Pick a date'),
                  onPressed: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now())
                      .then((date) => {
                            setState(() {
                              datepicked = date.day.toString() +
                                  '-' +
                                  date.month.toString() +
                                  '-' +
                                  date.year.toString();
                              dateonly = date.day.toString() +
                                  '/' +
                                  date.month.toString();
                            }),
                          })),
              FlatButton.icon(
                  icon: Icon(Icons.timer),
                  label: Text('Pick a Time'),
                  onPressed: () => showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((time) => {
                            setState(() {
                              timepicked = time.format(context).toString();
                            })
                          })),
            ]),
            SizedBox(height: 20),
            Text('How are you feeling right now?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('(Tap to Select and Tap again to deselect!)'),
            Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        GestureDetector(
                            child: MoodIcon(
                                image: moods[index].moodimage,
                                name: moods[index].name,
                                colour: moods[index].iselected
                                    ? Colors.black
                                    : Colors.white),
                            onTap: () => {
                                  if (ontapcount == 0)
                                    {
                                      setState(() {
                                        mood = moods[index].name;
                                        image = moods[index].moodimage;
                                        moods[index].iselected = true;
                                        ontapcount = ontapcount + 1;
                                        print(mood);
                                      }),
                                    }
                                  else if (moods[index].iselected)
                                    {
                                      setState(() {
                                        moods[index].iselected = false;
                                        ontapcount = 0;
                                      })
                                    }
                                }),
                      ],
                    );
                  }),
            ),
            Text('What have you been upto?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'Hold on any activity to select it. Multiple activities can be chosen.',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
            Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: act.length,
                  itemBuilder: (context, index) {
                    return Row(children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          child: ActivityIcon(
                              act[index].image,
                              act[index].name,
                              act[index].selected
                                  ? Colors.black
                                  : Colors.white),
                          onLongPress: () => {
                                if (act[index].selected)
                                  {
                                    setState(() {
                                      act[index].selected = false;
                                    })
                                  }
                                else
                                  setState(() {
                                    act[index].selected = true;
                                    Provider.of<MoodCard>(context,
                                            listen: false)
                                        .add(act[index]);
                                  }),
                              }),
                    ]);
                  }),
            ),
            FlatButton.icon(
                onPressed: () => {
                      datetime = datepicked + ' ' + timepicked,
                      setState(() {
                        Provider.of<MoodCard>(context, listen: false).addPlace(
                            datetime,
                            mood,
                            image,
                            Provider.of<MoodCard>(context, listen: false)
                                .activityimage
                                .join('_'),
                            Provider.of<MoodCard>(context, listen: false)
                                .activityname
                                .join('_'),
                            dateonly);
                      }),
                      Navigator.of(context).pushNamed('/home_screen'),
                    },
                icon: Icon(Icons.send),
                label: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.black),
                ))
          ]),
        ));
  }
}
