import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/request_service.dart';
import 'package:ajent/app/data/services/subscribe_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/chat/chat_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/shareable_user_item.dart';
import 'package:ajent/app/modules/ratings_view/widgets/a_rating_card.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCourseDetailController extends GetxController {
  Rx<Course> course;

  var isLoading = true.obs;
  var isJoining = false.obs;
  var isSharing = false.obs;
  var isRequesting = false.obs;
  var isLeaving = false.obs;

  var joinable = false.obs;
  var unEnrollable = false.obs;
  var requestable = false.obs;
  var editable = false.obs;
  var evaluable = false.obs;

  var scrollOffset = (0.0).obs;
  var showMore = false.obs;
  var userRelation = UserRelation.noRelation.obs;
  AjentUser teacher, owner;
  AjentUser user = HomeController.mainUser;
  var learners = <AjentUser>[].obs;
  var requestors = <String>[];
  String timeOverall = '';

  @override
  onInit() async {
    super.onInit();
    course.value = await CourseService.instance.getCourse(course.value.id);
    if (course.value.teacher != null && course.value.teacher.isNotEmpty)
      teacher = await UserService.instance.getUser(course.value.teacher);
    else
      teacher = null;
    owner = await UserService.instance.getUser(course.value.owner);
    if (course.value.learners != null) {
      learners.value =
          await CourseService.instance.getLearners(course.value.learners);
    }
    course.value.evaluations =
        await CourseService.instance.getEvaluations(course.value.id);
    requestors =
        await RequestService.instance.getCourseRequestors(course.value.id);
    setUserRelationBadge();
    settingBottomButton();
    getTimeInDetail();

    isLoading.value = false;
  }

  setUserRelationBadge() {
    if (course.value.learners.contains(user.uid)) {
      userRelation.value = UserRelation.joining;
    } else if (requestors.contains(user.uid)) {
      userRelation.value = UserRelation.requesting;
    } else if (teacher != null && teacher.uid == user.uid) {
      userRelation.value = UserRelation.teaching;
    }
  }

  settingBottomButton() {
    joinable.value = (course.value.status == CourseStatus.upcoming &&
        !requestors.contains(user.uid) &&
        course.value.maxLearner > course.value.learners.length &&
        !course.value.learners.contains(HomeController.mainUser.uid));
    if (joinable.value) {
      joinable.value = (course.value.hasTeacher())
          ? (course.value.teacher != HomeController.mainUser.uid)
          : joinable.value;
    }
    unEnrollable.value = (course.value.status == CourseStatus.upcoming &&
        (course.value.learners.contains(HomeController.mainUser.uid) &&
            course.value.owner != HomeController.mainUser.uid));
    requestable.value = (joinable.value &&
        course.value.owner != HomeController.mainUser.uid &&
        !requestors.contains(user.uid) &&
        (!course.value.hasTeacher()));
    editable.value = (HomeController.mainUser.uid == course.value.owner &&
        course.value.status == CourseStatus.upcoming);
    evaluable.value = (course.value.status == CourseStatus.fininished &&
        course.value.learners.contains(HomeController.mainUser.uid));
  }

  getTimeInDetail() {
    if (course.value.timeType == TimeType.periodTime) {
      timeOverall = course.value.getTotalHours().toStringAsFixed(1) +
          'hh'.tr +
          ' (${course.value.periods.length} ' +
          'period'.tr +
          ')';
    } else {
      timeOverall = course.value.getTotalHours().toStringAsFixed(1) +
          'hh'.tr +
          ' (${course.value.fixedTime.getTimeDetail()})';
    }
  }

  MyCourseDetailController(Course course) {
    this.course = course.obs;
  }

  joinCourse() async {
    isJoining.value = true;
    course.value.learners.add(HomeController.mainUser.uid);
    await CourseService.instance.updateLearnners(course.value);
    var user = await UserService.instance.getUser(HomeController.mainUser.uid);
    learners.insert(0, user);
    await NotificationService.instance.notifyJoinCourse(course.value, user);
    await SubscribeService.instance.subcribeOnJoinCourse(course.value.id);
    isJoining.value = false;
    joinable.value = false;
    unEnrollable.value = true;
    requestable.value = false;
    userRelation.value = UserRelation.joining;
  }

  leaveCourse() async {
    isLeaving.value = true;
    course.value.learners.remove(HomeController.mainUser.uid);
    await CourseService.instance.updateLearnners(course.value);
    learners
        .removeWhere((element) => element.uid == HomeController.mainUser.uid);
    unEnrollable.value = false;
    joinable.value = true;
    requestable.value = (joinable.value &&
        course.value.owner != HomeController.mainUser.uid &&
        (course.value.teacher == null || course.value.teacher.isEmpty));
    await SubscribeService.instance.unsubscribeOnLeaveCourse(course.value.id);
    await NotificationService.instance.notifyLeaveCourse(course.value, user);
    isLeaving.value = false;
    userRelation.value = UserRelation.noRelation;
  }

  sendRequest() async {
    isRequesting.value = true;
    Request request = Request()
      ..requestorUid = HomeController.mainUser.uid
      ..courseId = course.value.id
      ..receiverUid = course.value.owner
      ..status = RequestStatus.waiting
      ..postDate = DateTime.now().millisecondsSinceEpoch;
    request = await RequestService.instance.addRequest(request);
    Get.snackbar(
        'Send successfully'.tr, 'Your teaching request have been sent'.tr);
    await SubscribeService.instance
        .subcribeOnRequestCourse(course.value.id, request.id);
    await NotificationService.instance.notifyRequestCourse(course.value, user);
    requestable.value = false;
    joinable.value = false;
    isRequesting.value = false;
    userRelation.value = UserRelation.requesting;
  }

  evaluateCourse() async {
    if (course.value.evaluations.containsKey(user.uid)) {
      Get.dialog(AlertDialog(
        title: ARatingCard(
          evaluation: course.value.evaluations[user.uid],
          user: user,
          isExpandable: false,
        ),
      ));
    } else {
      Get.toNamed(Routes.RATING, arguments: course.value);
    }
  }

  showShareBottomSheet(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: Get.height * 0.4,
          child: StatefulBuilder(
            builder: (context, setShareBottomState) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: txtSearch,
                      decoration: searchTextfieldDecoration,
                      style: GoogleFonts.nunitoSans(fontSize: 14),
                      onChanged: (value) {
                        setShareBottomState(() {
                          if (value.isEmpty) {
                            return;
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.5,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: UserService.instance.searchUser(
                            keyword: txtSearch.text.trim().toLowerCase()),
                        builder: (context, snapshot) {
                          if (txtSearch.text.isEmpty) {
                            return Container();
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: ListTileShimmer(),
                            );
                          }
                          return ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length +
                                ((snapshot.connectionState ==
                                        ConnectionState.waiting)
                                    ? 2
                                    : 0),
                            itemBuilder: (context, index) {
                              if ((snapshot.connectionState ==
                                      ConnectionState.waiting) &&
                                  index > snapshot.data.docs.length - 1)
                                return ProfileShimmer();

                              AjentUser user = AjentUser.fromJson(
                                  snapshot.data.docs[index].id,
                                  snapshot.data.docs[index].data());
                              return Listener(
                                  onPointerDown: (e) => FocusManager
                                      .instance.primaryFocus
                                      .unfocus(),
                                  child: ShareableUserItem(
                                    user: user,
                                    course: course.value,
                                  ));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showMoreInfo(BuildContext context) {
    final titleStyle =
        GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold);
    final contentStyle = GoogleFonts.nunitoSans(
        fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white);
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      context: context,
      builder: (context) {
        return Container(
          height: Get.height * 0.25,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Extra infomation'.tr,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 5),
                  child: Row(
                    children: [
                      Text(
                        'Course ID: '.tr,
                        style: titleStyle,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(course.value.id.toUpperCase(),
                                style: contentStyle),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 5),
                  child: Row(
                    children: [
                      Text(
                        'Date created: '.tr,
                        style: titleStyle,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                                DateConverter.getTimeInDate(
                                    course.value.postDate),
                                style: contentStyle),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 5),
                  child: Row(
                    children: [
                      Text(
                        'Creator: '.tr,
                        style: titleStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PROFILEVIEW, arguments: owner);
                        },
                        child: Row(
                          children: [
                            UserAvatar(user: owner, size: 16),
                            SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  owner.name,
                                  style: contentStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
