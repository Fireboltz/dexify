class Tones {
  double score;
  String toneId;
  String toneName;

  Tones({this.score, this.toneId, this.toneName});

  Tones.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    toneId = json['tone_id'];
    toneName = json['tone_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['tone_id'] = this.toneId;
    data['tone_name'] = this.toneName;
    return data;
  }
}