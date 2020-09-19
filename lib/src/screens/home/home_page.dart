import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
                            HttpLink httpLink = HttpLink(uri: 'https://chapserver.herokuapp.com/');

                            ValueNotifier<GraphQLClient> client = ValueNotifier(
                              GraphQLClient(cache: InMemoryCache(), link: httpLink),
                            );
                            return App(auth: token != null, client: client);
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.message),
                  )),]),
        ));
  }
}