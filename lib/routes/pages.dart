import 'package:ajent/app/modules/auth/auth_binding.dart';
import 'package:ajent/app/modules/auth/auth_page.dart';
import 'package:ajent/app/modules/home/home_binding.dart';
import 'package:ajent/app/modules/home/home_page.dart';
import 'package:get/get.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.AUTH, page: () => AuthPage(), binding: AuthBinding()),
  ];
}
