import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetectionFromImage extends StatefulWidget {
  @override
  _FaceDetectionFromImageState createState() => _FaceDetectionFromImageState();
}

class _FaceDetectionFromImageState extends State<FaceDetectionFromImage> {
  double smProb = 0;
  List<Face> faces;
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
          mode: FaceDetectorMode.accurate,
          enableLandmarks: true,
          enableClassification: true));

  void pickAndProcessImage() async {
    ImagePicker ip = new ImagePicker();
    var picture = await ip.getImage(
      source: ImageSource.camera,
    );
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFilePath(picture.path);
    faces = await faceDetector.processImage(visionImage);
    if (faces.isNotEmpty) {
      smProb = faces[0].smilingProbability;
      if (smProb >= 0.75) {
        getData(0);
      } else if (smProb > 0.4 && smProb < 0.75) {
        getData(1);
      } else {
        getData(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2633C5),
        title: Text('Let\'s take a picture'),
      ),
      body: Center(
        child: Text('Press the floating button to take a picture!')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndProcessImage,
        child: Icon(Icons.camera),
      ),
    );
  }

  Future<void> getData(int query) async {
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
