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
  List<Tones> data;
  DocumentTone links;
  Meta meta;
  var dataNull = true;

  Future<String> getData(String query) async {
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
        data = new List<Tones>();
        parsed['document_tone']['tones'].forEach((v) {
          data.add(new Tones.fromJson(v));
        });
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
    TextEditingController _controller = TextEditingController();
    return new Scaffold(
      appBar: AppBar(
        title: Text("Mood dectection"),
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
                              controller: _controller,
                              decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async => {
                                    setState(() {
                                      dataNull = true;
                                    }),
                                    getData(_controller.text),
                                  },
                                  icon: Icon(FlutterIcons.search_mdi),
                                ),
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
                            ),
                          ])))),
            ),
            dataNull ? setDictNull() : setDict(),
          ],
        ),
      ),
    );
  }

  Widget setDictNull() {
    return EmptyDict();
  }

  Widget setDict() {
    return Column(
      children: [
        SizedBox(height: 8),
        ListView.builder(
          primary: false,
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: getCard,
          padding: EdgeInsets.all(0.0),
        )
      ],
    );
  }

  Widget getCard(BuildContext context, int index) {
    return new DictCard(data[index].score.toString(), data[index].toneId,
        data[index].toneName);
  }
}