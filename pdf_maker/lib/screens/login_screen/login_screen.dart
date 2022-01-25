import 'package:flutter/material.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/screens/login_screen/login_screen_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const MainBackgroundWidget(),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const welcomeText(),

                socialLogin()
              ],
            ),
          )

        ],
      ),
    );
  }
}
