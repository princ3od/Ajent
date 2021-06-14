import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/student_detail.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class MyStudentBottomSheet extends StatelessWidget {
  final MyProfileController controller;
  MyStudentBottomSheet({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Thêm học sinh +'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentDetail(controller: controller)),
          );
        },
        backgroundColor: Colors.black,
      ),
      body: Obx(
        () => Container(
          height: double.infinity,
          color: Colors.white,
          child: ListView.builder(
            itemCount: controller.students.length,
            itemBuilder: (context, index) {
              var item = controller.students[index];
              return Dismissible(
                key: ObjectKey(controller.students[index]),
                onDismissed: (direction) async {
                  //TODO Handellimg Remove Student In DB
                  bool success = await controller.userService
                      .delStudent(HomeController.mainUser.uid, item.id);
                  if (success) controller.students.remove(item);
                },
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('profile_confirm_dismiss_title'.tr),
                        content: Text('profile_confirm_dismiss_message'.tr),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                  'profile_confirm_dismiss_DELETE_label'.tr)),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                  'profile_confirm_dismiss_cancel_label'.tr)),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: ShapeDecoration(
                    color: Colors.deepOrange.withAlpha(125),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    //TODO add function handler edit progress uer diploma here
                    onTap: () => print('On tap'),
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: (controller.students[index].gender ==
                              Gender.female)
                          ? AssetImage(
                              'assets/images/default_avatar_female.png')
                          : AssetImage('assets/images/default_avatar_male.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('${controller.students[index].name}'),
                    subtitle: Text('${controller.students[index].mail}'),
                    trailing: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
