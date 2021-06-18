import 'package:get/get.dart';

import 'package:ajent/app/data/models/chat_group.dart';

class TextingController extends GetxController {
  var isLoadingGroup = false.obs;
  RxList<ChatGroup> chatGroups = [].obs;
}
