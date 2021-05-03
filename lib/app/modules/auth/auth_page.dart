import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lottie/lottie.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Error!")));
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Welcome to Ajent",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //Image.asset("assets/images/bg.png"),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Lottie.asset("assets/json/prm.json"),
                          ),
                          buildSignIn(),
                        ],
                      ),
                    ),
                    Text("Copyright © 2021 Ajent Corps."),
                    SizedBox(height: 40)
                  ],
                ),
              ),
            ),
          );
        } else
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Welcome to Ajent",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Lottie.asset("assets/json/prm.json"),
                        ),
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Initilizing..."),
                      ],
                    ),
                  ),
                  Text("Copyright © 2021 Ajent Corps."),
                  SizedBox(height: 40)
                ],
              ),
            ),
          );
      },
    );
  }

  Widget buildSignIn() {
    return Column(
      children: [
        SignInButton(
          Buttons.GoogleDark,
          text: "Continute with Google",
          onPressed: () {
            //
          },
        ),
        SignInButton(
          Buttons.Facebook,
          text: "Continute with Facebook",
          onPressed: () {
            //
          },
        )
      ],
    );
  }
}
