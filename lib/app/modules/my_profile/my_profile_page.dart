import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatelessWidget {
  final MyProfileController controller = Get.find<MyProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'my_profile_title_label'.tr,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: UserAvatar(
                  user: HomeController.mainUser,
                  size: 45,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  //TODO add function handler changing progress user avatar here
                  onPressed: () {},
                  child: Text('profile_changed_image_label'.tr),
                  style: whiteButtonStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('ajent_user_name_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.name),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text("email_label".tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.mail),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text('school_name_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.mail),
              ),
              SizedBox(
                height: 20,
              ),
              Text('phone_number_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                keyboardType: TextInputType.phone,
                controller:
                    TextEditingController(text: HomeController.mainUser.phone),
              ),
              SizedBox(
                height: 20,
              ),
              Text('ajent_user_major_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.mail),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ajent_user_education_level_label'.tr,
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      value: (controller.dropdownValue.value != '')
                          ? controller.dropdownValue.value
                          : null,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        controller.dropdownValue.value = newValue;
                        print('${controller.dropdownValue.value}');
                      },
                      items: controller.dropDownMenuItems,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('ajent_bio_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.mail),
              ),
              SizedBox(
                height: 20,
              ),
              Text('ajent_education_degrees_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              Obx(
                () => Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: controller.ajentUser.value.degrees.length,
                    itemBuilder: (context, index) {
                      var item = controller.ajentUser.value.degrees[index];
                      return Dismissible(
                        key: ObjectKey(
                            controller.ajentUser.value.degrees[index]),
                        onDismissed: (direction) {
                          controller.ajentUser.value.degrees.remove(item);
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('profile_confirm_dismiss_title'.tr),
                                content:
                                    Text('profile_confirm_dismiss_message'.tr),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text(
                                          'profile_confirm_dismiss_DELETE_label'
                                              .tr)),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(
                                          'profile_confirm_dismiss_cancel_label'
                                              .tr)),
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
                              backgroundImage: NetworkImage(controller
                                  .ajentUser.value.degrees[index].imageUrl),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(
                                '${controller.ajentUser.value.degrees[index].title}'),
                            subtitle: Text(
                                '${controller.ajentUser.value.degrees[index].description}'),
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
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Get.bottomSheet(
                          Container(
                            height: double.infinity,
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount:
                                  controller.ajentUser.value.students.length,
                              itemBuilder: (context, index) {
                                var item =
                                    controller.ajentUser.value.students[index];
                                return Dismissible(
                                  key: ObjectKey(controller
                                      .ajentUser.value.students[index]),
                                  onDismissed: (direction) {
                                    controller.ajentUser.value.students
                                        .remove(item);
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'profile_confirm_dismiss_title'
                                                  .tr),
                                          content: Text(
                                              'profile_confirm_dismiss_message'
                                                  .tr),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: Text(
                                                    'profile_confirm_dismiss_DELETE_label'
                                                        .tr)),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: Text(
                                                    'profile_confirm_dismiss_cancel_label'
                                                        .tr)),
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
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      contentPadding: const EdgeInsets.all(8.0),
                                      //TODO add function handler edit progress uer diploma here
                                      onTap: () => print('On tap'),
                                      leading: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: (controller
                                                    .ajentUser
                                                    .value
                                                    .students[index]
                                                    .gender ==
                                                Gender.female)
                                            ? AssetImage(
                                                'assets/images/default_avatar_female.png')
                                            : AssetImage(
                                                'assets/images/default_avatar_male.png'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      title: Text(
                                          '${controller.ajentUser.value.students[index].name}'),
                                      subtitle: Text(
                                          '${controller.ajentUser.value.students[index].mail}'),
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
                        );
                      },
                      icon: Icon(Icons.group),
                      label: Text('My Students'),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          controller.showOverlay(context);
                        },
                        icon: Icon(Icons.add_circle),
                        label: Text('profile_add_diploma_label'.tr)),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('profile_save_label'.tr),
                  style: orangeButtonStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
