import 'dart:async';
import 'dart:convert';
import 'package:dexify/src/json_models/document_tone.dart';
import 'package:dexify/src/json_models/meta.dart';
import 'package:dexify/src/json_models/tones.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';

import 'dict_card.dart';
import 'empty_dict.dart';

class Mood extends StatefulWidget {
  @override
  _Mood createState() => new _Mood();
}

class _Mood extends State<Mood> {
  Tones data;
  DocumentTone links;
  Meta meta;
  var dataNull = true;

  Future<String> getData(String query) async {
    double score=0.0;
    var client = new http.Client();
    try {
      var queryLink = Uri.encodeFull('https://api.eu-gb.tone-analyzer.watson.cloud.ibm.com/instances/86671942-7e41-4214-a4e6-6077786553c8/v3/tone?version=2017-09-21&sentences=false&text=$query');
      print(queryLink);
      var response = await client.get(queryLink,
        headers: {
          "Authorization": "Basic YXBpa2V5OndKZlVhVDdaVEt2S0hTdXZ4VmdMRWpsaERzNWN5WE9NZzJmYVctblpaN0dB",
        },
      );
      var parsed = json.decode(response.body);
      if (parsed['document_tone'] != null) {
        data = Tones();
        parsed['document_tone']['tones'].forEach((v) {
          if(v['score']>score){
            data= new Tones.fromJson(v);
          }
        });
        getQuote(detectEmotion(data.toneId));
      }
      setState(() {
        dataNull = false;
      });
    } finally {
      client.close();

    }

    return "Success!";
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller_1 = TextEditingController();
    TextEditingController _controller_2 = TextEditingController();
    TextEditingController _controller_3 = TextEditingController();
    TextEditingController _controller_4 = TextEditingController();

    return new Scaffold(
      appBar: AppBar(
        title: Text("Let's cheer up"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Center(
              child: new Container(
                  padding: const EdgeInsets.all(30.0),
                  color: Colors.white,
                  child: new Container(
                      child: new Center(
                          child: new Column(children: [
                            new Text(
                              'Hey !',
                              style: new TextStyle(fontSize: 25.0),
                            ),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new TextFormField(
                              controller: _controller_1,
                              decoration: new InputDecoration(
                                labelText: "How are you feeling today ?",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                              validator: (value){
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new TextFormField(
                              controller: _controller_2,
                              decoration: new InputDecoration(
                                labelText: "How did you spend today's today ?",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                                validator: (value){
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }
                            ),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new TextFormField(
                              controller: _controller_3,
                              decoration: new InputDecoration(
                                labelText: "What are you planing to do for the rest of the day?",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                                validator: (value){
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }
                            ),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new TextFormField(
                              controller: _controller_4,
                              decoration: new InputDecoration(
                                labelText: "Whatcha you been upto ?",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                                validator: (value){
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }
                            ),
                            new Padding(padding: EdgeInsets.only(top: 100.0)),
                            RaisedButton(
                              onPressed: () async => {
                                setState(() {
                                  dataNull = true;
                                }),
                                getData(_controller_1.text+"\t"+_controller_2.text+"\t"+_controller_3.text+"\t"+_controller_4.text),
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child:
                                const Text('Let Go', style: TextStyle(fontSize: 30)),
                              ),
                            )
                          ])))),
            ),
          ],
        ),
      ),
    );
  }
  
 
  int detectEmotion(String emotion){
    if(emotion=="tentative"||emotion=="analytical") {
      return 1;
    } else if(emotion=="joy"||emotion=="confident"){
      return 0;
    }
    else
      return 2;

  }

  Future<void> getQuote(int query) async {
    var client = new http.Client();
    try {
      var queryLink = 'https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json&json=?';
      print(queryLink);
      var response = await client.get(queryLink);
      String fixed = response.body.replaceAll(r"\'", "'");
      var parsed = json.decode(fixed);
      print(parsed);
      var quote = parsed['quoteText'] + " ~ " + parsed['quoteAuthor'];
      if (query == 0) {
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
                    content: Column(
                      children: [
                        new Text("You're happy!! Stay that way and make others happy as well!"),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        SizedBox(width: 15),
                        new Image.network("https://lh3.googleusercontent.com/-3X_sB_x3qHE/WdnXIxLg3rI/AAAAAAAABH4/PSll0XoVfOwAd-vo9tb19wIfocogU9gngCHMYCw/s640/blogger-image--1568789223.jpg"),
                        SizedBox(width: 20),
                        new Text("$quote"),
                      ],
                    ),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      } else if (query == 1) {
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
                    title: Text('You could be happier!'),
                    content: Column(
                      children: [
                        new Text("You're doing great! Here is some motivation for you to do even better!!"),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        SizedBox(height: 15),
                        new Image.network("https://images.unsplash.com/photo-1494178270175-e96de2971df9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
                        new Text(" "),
                        new Text(" "),
                        new Text("$quote"),
                      ],
                    ),
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
                    title: Text('Never give up!'),
                    content: Column(
                      children: [
                        new Text("Today might not be your day. But tomorrow will definately be!"),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        SizedBox(width: 15),
                        new Image.network("https://miro.medium.com/max/8500/0*ikplDBIIKNZAmups"),
                        SizedBox(width: 20),
                        new Text("$quote"),
                      ],
                    ),
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
    } finally {
      client.close();
    }

    return "Success!";
  }
}