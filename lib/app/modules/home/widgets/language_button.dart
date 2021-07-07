import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/core/values/lang/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({Key key}) : super(key: key);

  @override
  _LanguageButtonState createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    var langText = {
      'vi': 'Tiếng Việt',
      'en': 'English (US)',
    };
    var langImage = {
      'vi': 'assets/images/vi.png',
      'en': 'assets/images/en.png',
    };
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Column(
                  children: [
                    for (var item in langText.keys)
                      buildLang(langImage, langText, item, () async {
                        HomeController.langCode = item;
                        LocalizationService.changeLocale(item);
                        print(item);
                        var _pref = await SharedPreferences.getInstance();
                        _pref.setString('lang', item);
                        Navigator.pop(context);
                      }),
                  ],
                ),
              ),
            );
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    langImage[HomeController.langCode],
                    fit: BoxFit.fitWidth,
                    width: 32,
                    height: 32,
                  ),
                ),
                radius: 16.0,
              ),
              SizedBox(width: 10),
              Text("${langText[HomeController.langCode]}"),
            ],
          ),
        ));
  }

  Material buildLang(Map<String, String> langImage,
      Map<String, String> langText, String locale, Function onTap) {
    return Material(
      color: (HomeController.langCode == locale)
          ? primaryColor.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    langImage[locale],
                    fit: BoxFit.fitWidth,
                    width: 32,
                    height: 32,
                  ),
                ),
                radius: 16.0,
              ),
              SizedBox(width: 10),
              Text(
                "${langText[locale]}",
                style: GoogleFonts.nunitoSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
