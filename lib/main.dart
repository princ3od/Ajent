import 'package:ajent/app/modules/splash/splash_binding.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ajent",
      getPages: AppPages.pages,
      initialRoute: Routes.SPLASH,
      //initialRoute: Routes.MYCOURSEDETAIL,
      initialBinding: SplashBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
