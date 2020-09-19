import 'package:dexify/src/facial_emotion_detection/face_detection_image.dart';
import 'package:dexify/src/models/moodcard.dart';
import 'package:dexify/src/mood_tracker/chart.dart';
import 'package:dexify/src/mood_tracker/homepage.dart';
import 'package:dexify/src/mood_tracker/start.dart';
import 'package:dexify/src/tone_analyser/mood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      setState(() => prefs = pref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            var token = prefs.getString('token');
                            HttpLink httpLink = HttpLink(
                                uri: 'https://chapserver.herokuapp.com/');

                            ValueNotifier<GraphQLClient> client = ValueNotifier(
                              GraphQLClient(
                                  cache: InMemoryCache(), link: httpLink),
                            );
                            return App(auth: token != null, client: client);
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.message),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ChangeNotifierProvider.value(
                                notifier: MoodCard(),
                                child: MaterialApp(
                                  title: 'Dexify',
                                  debugShowCheckedModeBanner: false,
                                  theme: ThemeData(
                                    primarySwatch: Colors.blue,
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                  ),
                                  home: StartPage(),
                                  routes: {
                                    '/home_screen': (ctx) => HomeScreen(),
                                    '/chart': (ctx) => MoodChart(),
                                  },
                                ));
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.note_add),
                  )),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () { showAlertDialog(context); },
                  child: Icon(FlutterIcons.mood_mdi),
                ),
              )
            ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Take Picture"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FaceDetectionFromImage()),
        );
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Answer a few questions"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mood()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Let's cheer up!"),
      content: Text(
          "Would you like us to detect your mood via your photo or by answering a few questions??"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
