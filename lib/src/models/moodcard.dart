import 'package:flutter/cupertino.dart';
import 'package:dexify/src/helpers/db_helper.dart';
import 'package:dexify/src/helpers/mooddata.dart';
import 'package:dexify/src/models/activity.dart';

class MoodCard extends ChangeNotifier {
  String datetime;
  String mood;
  List<String> activityname = [];
  List<String> activityimage = [];
  String image;
  String actimage;
  String actname;

  MoodCard({this.actimage, this.actname, this.datetime, this.image, this.mood});

  List items;
  List<MoodData> data = [];
  String date;
  bool isloading = false;
  List<String> actiname = [];

  void add(Activity act) {
    activityimage.add(act.image);
    activityname.add(act.name);
    notifyListeners();
  }

  Future<void> addPlace(String datetime, String mood, String image,
      String actimage, String actname, String date) async {
    DBHelper.insert('user_moods', {
      'datetime': datetime,
      'mood': mood,
      'image': image,
      'actimage': actimage,
      'actname': actname,
      'date': date
    });
    notifyListeners();
  }

  Future<void> deletePlaces(String datetime) async {
    DBHelper.delete(datetime);
    notifyListeners();
  }
}
