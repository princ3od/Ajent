class Evaluation {
  int star;
  String content;
  Evaluation(this.star, this.content);

  bool isEvaluate() {
    return (star > -1 && content != null);
  }
}
