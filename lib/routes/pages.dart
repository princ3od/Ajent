import 'package:ajent/app/modules/%20regulations_and_policies/regulations_and_policies_page.dart';
import 'package:ajent/app/modules/about/about_page.dart';
import 'package:ajent/app/modules/add_course/add_course_page.dart';
import 'package:ajent/app/modules/auth/otp_verification_page.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_page.dart';
import 'package:ajent/app/modules/auth/auth_binding.dart';
import 'package:ajent/app/modules/auth/login_page.dart';
import 'package:ajent/app/modules/auth/signup_page.dart';
import 'package:ajent/app/modules/auth/welcome_page.dart';
import 'package:ajent/app/modules/home/home_binding.dart';
import 'package:ajent/app/modules/home/home_page.dart';
import 'package:ajent/app/modules/my_profile/my_profile_binding.dart';
import 'package:ajent/app/modules/my_profile/my_profile_page.dart';
import 'package:ajent/app/modules/my_teaching_detail/my_teaching_detail_page.dart';
import 'package:ajent/app/modules/onboard_intro/onboard_intro_page.dart';
import 'package:ajent/app/modules/profile_view/profile_view_page.dart';
import 'package:ajent/app/modules/rating/rating_page.dart';
import 'package:ajent/app/modules/ratings_view/ratings_view_page.dart';
import 'package:ajent/app/modules/request/request_page.dart';
import 'package:ajent/app/modules/search/search_screen.dart';
import 'package:ajent/app/modules/settings/setting_page.dart';
import 'package:ajent/app/modules/splash/splash_binding.dart';
import 'package:ajent/app/modules/splash/splash_page.dart';
import 'package:ajent/app/modules/texting/texting_page.dart';
import 'package:ajent/app/modules/texting/texting_binding.dart';
import 'package:ajent/app/modules/chat/chat_page.dart';
import 'package:ajent/app/modules/edit_course/edit_course_page.dart';

import 'package:get/get.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.WELCOME, page: () => WelcomePage()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.AUTH, page: () => LoginPage(), binding: AuthBinding()),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.VERIFICATION,
      page: () => OtpVerificationPage(),
      binding: AuthBinding(),
    ),
    GetPage(
        name: Routes.PROFILE,
        page: () => MyProfilePage(),
        binding: MyProfileBinding()),
    GetPage(name: Routes.MYCOURSEDETAIL, page: () => MyCourseDetailPage()),
    GetPage(name: Routes.MYTEACHINGDETAIL, page: () => MyTeachingDetailPage()),
    GetPage(name: Routes.RATING, page: () => RatingPage()),
    GetPage(name: Routes.SEARCH, page: () => SearchScreen()),
    GetPage(name: Routes.PROFILEVIEW, page: () => ProfileViewPage()),
    GetPage(
      name: Routes.ADD_COURSE,
      page: () => AddCoursePage(),
    ),
    GetPage(
        name: Routes.TEXTING,
        page: () => TextingPage(),
        binding: TextingBinding()),
    GetPage(name: Routes.CHATTING, page: () => ChatPage()),
    GetPage(name: Routes.SETTINGS, page: () => SettingsPage()),
    GetPage(name: Routes.TERMS, page: () => RegulationsAndPoliciesPage()),
    GetPage(name: Routes.VIEWRATING, page: () => RatingsViewPage()),
    GetPage(name: Routes.REQUEST_VIEW, page: () => RequestPage()),
    GetPage(name: Routes.ONBOARDINTRO, page: () => OnboardIntroPage()),
    GetPage(name: Routes.ABOUT, page: () => AboutPage()),
    GetPage(name: Routes.EDIT_COURSE, page: () => EditCoursePage()),
  ];
}
