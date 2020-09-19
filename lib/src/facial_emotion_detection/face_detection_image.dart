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

      } else if (smProb > 0.4 && smProb < 0.75) {

      } else {

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face detection with Smile'),
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
}
