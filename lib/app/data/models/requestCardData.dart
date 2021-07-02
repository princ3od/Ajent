import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';

class RequestCardData {
  Course course;
  Request request;
  AjentUser requestor;
  double star;
  RequestCardData({this.course, this.request, this.requestor, this.star});
}
