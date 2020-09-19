import 'document_tone.dart';

class Meta {
  DocumentTone documentTone;

  Meta({this.documentTone});

  Meta.fromJson(Map<String, dynamic> json) {
    documentTone = json['document_tone'] != null
        ? new DocumentTone.fromJson(json['document_tone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documentTone != null) {
      data['document_tone'] = this.documentTone.toJson();
    }
    return data;
  }
}