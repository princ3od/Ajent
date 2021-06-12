import 'package:ajent/app/modules/splash/splash_binding.dart';
import 'package:ajent/core/values/colors.dart';
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

const MaterialColor jetblack =
    const MaterialColor(0xff000000, const <int, Color>{
  50: const Color(0xff000000),
  100: const Color(0xff000000),
  200: const Color(0xff000000),
  300: const Color(0xff000000),
  400: const Color(0xff000000),
  500: const Color(0xff000000),
  600: const Color(0xff000000),
  700: const Color(0xff000000),
  800: const Color(0xff000000),
  900: const Color(0xff000000),
});

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
        primarySwatch: jetblack,
        primaryColor: primaryColor,
      ),
      translations: LocalizationService(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
    );
  }
}
