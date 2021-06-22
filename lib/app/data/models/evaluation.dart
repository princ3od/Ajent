class Evaluation {
  int star;
  String content;
  String evaluatorUid;
  Evaluation();
  Evaluation.fromJson(String uid, Map<String, dynamic> data) {
    evaluatorUid = uid;
    star = data['star'];
    content = data['content'];
  }
  Map<String, dynamic> toJson() {
    return {
      'star': star,
      'content': content,
    };
  }

  bool isEvaluate() {
    return (star > -1 && content != null);
  }
}
