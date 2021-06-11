import 'package:ajent/app/modules/splash/splash_binding.dart';
import 'package:ajent/core/values/lang/localization_service.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
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
      initialBinding: SplashBinding(),
      theme: ThemeData(
        fontFamily:
            GoogleFonts.nunitoSans(fontWeight: FontWeight.w700).fontFamily,
        primarySwatch: Colors.deepOrange,
      ),
      translations: LocalizationService(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
    );
  }
}
