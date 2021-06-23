import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/degree_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DegreesTab extends StatelessWidget {
  final MyProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height -
          kBottomNavigationBarHeight * 2 -
          kFloatingActionButtonMargin * 2 -
          200,
      child: Obx(
        () => (controller.loadDegree.value)
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: controller.ajenDegree.length,
                itemBuilder: (context, index) {
                  return DegreeItem(
                      onLongPress: (value) async {
                        await controller.onLongPressDegreeCard(value);
                      },
                      degree: controller.ajentUser.value.degrees[index]);
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
// Obx(
//         () => ListView.builder(
//           itemCount: controller.degrees.length,
//           itemBuilder: (context, index) {
//             var item = controller.degrees[index];
//             return Dismissible(
//               key: ObjectKey(controller.degrees[index]),
//               onDismissed: (direction) {},
//               confirmDismiss: (DismissDirection direction) async {
//                 return await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('profile_confirm_dismiss_title'.tr),
//                       content: Text('profile_confirm_dismiss_message'.tr),
//                       actions: <Widget>[
//                         TextButton(
//                             onPressed: () async {
//                               bool success = await controller.userService
//                                   .delDegree(
//                                       HomeController.mainUser.uid, item.id);
//                               if (success) {
//                                 controller.degrees.remove(item);
//                                 Navigator.of(context).pop(true);
//                               }
//                             },
//                             child: Text(
//                                 'profile_confirm_dismiss_DELETE_label'.tr)),
//                         TextButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: Text(
//                                 'profile_confirm_dismiss_cancel_label'.tr)),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 2.0),
//                 decoration: ShapeDecoration(
//                   color: Colors.deepOrange.withAlpha(125),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(32.0),
//                   ),
//                 ),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(32.0),
//                   ),
//                   contentPadding: const EdgeInsets.all(8.0),
//                   onTap: () => print('On tap'),
//                   leading: CircleAvatar(
//                     radius: 30.0,
//                     backgroundImage:
//                         NetworkImage(controller.degrees[index].imageUrl),
//                     backgroundColor: Colors.transparent,
//                   ),
//                   title: Text('${controller.degrees[index].title}'),
//                   subtitle: Text('${controller.degrees[index].description}'),
//                   trailing: IconButton(
//                     onPressed: null,
//                     icon: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 25,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
