import 'package:dexify/src/json_models/tones.dart';

class DocumentTone {
  List<Tones> tones;

  DocumentTone({this.tones});

  DocumentTone.fromJson(Map<String, dynamic> json) {
    if (json['tones'] != null) {
      tones = new List<Tones>();
      json['tones'].forEach((v) {
        tones.add(new Tones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tones != null) {
      data['tones'] = this.tones.map((v) => v.toJson()).toList();
    }
    return data;
  }
}