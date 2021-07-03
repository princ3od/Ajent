import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/models/ajent_user.dart';
import '../../data/models/evaluation.dart';
import '../../data/services/user_service.dart';

class RatingViewController extends GetxController {
  var originalEvaluations = <Evaluation>[];
  int currentIndex = 0, maxIndex = 20;
  Map<String, AjentUser> users = Map();
  bool loadDone = false;
  ScrollController scrollControler = ScrollController();

  var evaluations = <Evaluation>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    originalEvaluations = Get.arguments.values.toList();
    originalEvaluations.sort((a, b) => b.postDate.compareTo(a.postDate));
    scrollControler.addListener(() {
      if (scrollControler.position.atEdge) {
        if (scrollControler.position.pixels == 0)
          print('ListView scrolled to top');
        else if (!loadDone) {
          fetchEvaluations();
        }
      }
    });
    fetchEvaluations();
    super.onInit();
  }

  fetchEvaluations() async {
    maxIndex = (maxIndex + 5 <= originalEvaluations.length)
        ? maxIndex + 5
        : originalEvaluations.length;
    loadDone = (maxIndex == originalEvaluations.length);
    isLoading.value = true;
    await Future.delayed(Duration(milliseconds: 400));
    for (; currentIndex < maxIndex; currentIndex++) {
      if (!users.containsKey(originalEvaluations[currentIndex].evaluatorUid)) {
        AjentUser user = await UserService.instance
            .getUser(originalEvaluations[currentIndex].evaluatorUid);
        users[user.uid] = user;
      }
      evaluations.add(originalEvaluations[currentIndex]);
    }
    print(users.length);
    evaluations.refresh();
    isLoading.value = false;
  }
}
