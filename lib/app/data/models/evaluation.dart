class Evaluation {
  int star;
  String content;
  String evaluatorUid;
  int postDate;
  Evaluation();
  Evaluation.fromJson(String uid, Map<String, dynamic> data) {
    evaluatorUid = uid;
    star = data['star'];
    content = data['content'];
    postDate = data['postDate'];
  }
  Map<String, dynamic> toJson() {
    return {
      'star': star,
      'content': content,
      'postDate': DateTime.now().millisecondsSinceEpoch,
    };
  }

  bool isEvaluate() {
    return (star > -1 && content != null);
  }
}
