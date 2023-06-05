import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loveefy/src/features/auth/presentation/screens/email_reg_screen.dart';
import 'package:loveefy/src/features/auth/presentation/screens/log_in_screen.dart';

import 'package:loveefy/src/features/auth/presentation/shared_widgets/landing_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFFF3F3F3),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  SvgPicture.asset(
                    'asset/images/tinder.svg',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  //buttons
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const EmailRegistrationScreen();
                                  },
                                )),
                            child: const LandingButton(text: 'Sign Up')),
                        GestureDetector(
                           onTap: () =>
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                )),
                            child: const LandingButton(text: 'Log In')),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
