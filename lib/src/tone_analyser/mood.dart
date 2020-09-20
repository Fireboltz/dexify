import 'dart:async';
import 'dart:convert';
import 'package:dexify/src/json_models/document_tone.dart';
import 'package:dexify/src/json_models/meta.dart';
import 'package:dexify/src/json_models/tones.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Mood extends StatefulWidget {
  @override
  _Mood createState() => new _Mood();
}

class _Mood extends State<Mood> {
  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Let's cheer up"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.purple, Colors.deepPurple])),
        ),
      ),
      body: new StepperBody(),
    );
  }
}

class MyQuestions {
  String question1 = '';
  String question2 = '';
  String question3 = '';
  String question4 = '';
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  Tones data;
  DocumentTone links;
  Meta meta;
  var dataNull = true;

  Future<String> getData(String query) async {
    double score = 0.0;
    var client = new http.Client();
    try {
      var queryLink = Uri.encodeFull(
          'https://api.eu-gb.tone-analyzer.watson.cloud.ibm.com/instances/86671942-7e41-4214-a4e6-6077786553c8/v3/tone?version=2017-09-21&sentences=false&text=$query');
      print(queryLink);
      var response = await client.get(
        queryLink,
        headers: {
          "Authorization":
              "Basic YXBpa2V5OndKZlVhVDdaVEt2S0hTdXZ4VmdMRWpsaERzNWN5WE9NZzJmYVctblpaN0dB",
        },
      );
      var parsed = json.decode(response.body);
      if (parsed['document_tone'] != null) {
        data = Tones();
        parsed['document_tone']['tones'].forEach((v) {
          if (v['score'] > score) {
            data = new Tones.fromJson(v);
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

  Future<void> getQuote(int query) async {
    var client = new http.Client();
    try {
      var queryLink =
          'https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json&json=?';
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
                        new Text(
                            "You're happy!! Stay that way and make others happy as well!"),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        SizedBox(width: 15),
                        new Image.network(
                            "https://lh3.googleusercontent.com/-3X_sB_x3qHE/WdnXIxLg3rI/AAAAAAAABH4/PSll0XoVfOwAd-vo9tb19wIfocogU9gngCHMYCw/s640/blogger-image--1568789223.jpg"),
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
                        new Text(
                            "You're doing great! Here is some motivation for you to do even better!!"),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        SizedBox(height: 15),
                        new Image.network(
                            "https://images.unsplash.com/photo-1494178270175-e96de2971df9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
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
                        new Text(
                            "Today might not be your day. But tomorrow will definately be!"),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        SizedBox(width: 15),
                        new Image.network(
                            "https://miro.medium.com/max/8500/0*ikplDBIIKNZAmups"),
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

  int detectEmotion(String emotion) {
    if (emotion == "tentative" || emotion == "analytical") {
      return 1;
    } else if (emotion == "joy" || emotion == "confident") {
      return 0;
    } else
      return 2;
  }

  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyQuestions questions = new MyQuestions();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    return new Container(
        child: new Form(
            key: _formKey,
            child: new ListView(children: <Widget>[
              new Theme(
                data: ThemeData(
                  primaryColor: Colors.deepPurpleAccent,
                ),
                child: new Stepper(
                  steps: <Step>[
                    new Step(
                        title: const Text('How are you feeling today ?'),
                        isActive: true,
                        //state: StepState.error,
                        state: StepState.indexed,
                        content: new TextFormField(
                          focusNode: _focusNode,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          onSaved: (String value) {
                            questions.question1 = value;
                          },
                          maxLines: 2,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Opps! you forgot to fill an answer';
                            }
                          },
                          decoration: new InputDecoration(
                              hintText: 'Enter your answer',
                              //filled: true,
                              labelStyle: new TextStyle(
                                  decorationStyle: TextDecorationStyle.solid)),
                        )),
                    new Step(
                        title: const Text('How did you spend today ?'),
                        isActive: true,
                        state: StepState.indexed,
                        content: new TextFormField(
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Opps! you forgot to fill an answer';
                            }
                          },
                          onSaved: (String value) {
                            questions.question2 = value;
                          },
                          maxLines: 2,
                        )),
                    new Step(
                        title: const Text(
                            'What are your plans for the rest of the day?'),
                        // subtitle: const Text('Subtitle'),
                        isActive: true,
                        state: StepState.indexed,
                        content: new TextFormField(
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Opps! you forgot to fill an answer';
                            }
                          },
                          onSaved: (String value) {
                            questions.question3 = value;
                          },
                          maxLines: 2,
                        )),
                    new Step(
                        title: const Text('Whatcha been upto'),
                        isActive: true,
                        state: StepState.indexed,
                        content: new TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Opps! you forgot to fill an answer';
                            }
                          },
                          maxLines: 2,
                          onSaved: (String value) {
                            questions.question4 = value;
                          },
                        )),
                  ],
                  type: StepperType.vertical,
                  currentStep: this.currStep,
                  onStepContinue: () {
                    setState(() {
                      if (currStep < 3) {
                        currStep = currStep + 1;
                      } else {
                        currStep = 0;
                      }
                      // else {
                      // Scaffold
                      //     .of(context)
                      //     .showSnackBar(new SnackBar(content: new Text('$currStep')));

                      // if (currStep == 1) {
                      //   print('First Step');
                      //   print('object' + FocusScope.of(context).toStringDeep());
                      // }

                      // }
                    });
                  },
                  onStepCancel: () {
                    setState(() {
                      if (currStep > 0) {
                        currStep = currStep - 1;
                      } else {
                        currStep = 0;
                      }
                    });
                  },
                  onStepTapped: (step) {
                    setState(() {
                      currStep = step;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft,
                  ),
                ),
                child: FlatButton(
                  child: Text(
                    "Let's Go",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async => {_submitDetails()},
                ),
              ),
            ])));
  }

  void _submitDetails() {
    final FormState formState = _formKey.currentState;
    formState.save();
    getData(questions.question1 +
        " " +
        questions.question2 +
        " " +
        questions.question3 +
        " " +
        questions.question4);
  }
}
