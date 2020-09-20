import 'package:dexify/app_themes/dexify_app_theme.dart';
import 'package:dexify/src/facial_emotion_detection/face_detection_image.dart';
import 'package:dexify/src/tone_analyser/mood.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class EmotionTrackerView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const EmotionTrackerView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    DexifyAppTheme.nearlyDarkBlue,
                    HexColor("#6F56E8")
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DexifyAppTheme.grey.withOpacity(0.6),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Let\'s get motivated!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: DexifyAppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: DexifyAppTheme.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'You can either answer a series of questions or click a selfie using which the app will detect your mood and provide you with some positivity because you deserve it :) \n\nClick on the button below to get started.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: DexifyAppTheme.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            letterSpacing: 0.0,
                            color: DexifyAppTheme.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: DexifyAppTheme.nearlyWhite,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: DexifyAppTheme.nearlyBlack
                                          .withOpacity(0.4),
                                      offset: Offset(8.0, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IconButton(
                                  icon: new Icon(Icons.arrow_right),
                                  color: HexColor("#6F56E8"),
                                  iconSize: 44,
                                  onPressed: () { showAlertDialog(context); },
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
