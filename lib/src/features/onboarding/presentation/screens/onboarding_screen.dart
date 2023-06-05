import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loveefy/src/core/constants.dart';
import 'package:loveefy/src/features/auth/presentation/screens/landing_page.dart';
import 'package:loveefy/src/features/onboarding/presentation/screens/onboarding_slide.dart';
import 'package:loveefy/src/features/onboarding/presentation/shared_widgets/onboarding_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: [
                OnboardingSlide(
                    imagePath: onboardingGirl1,
                    screenText: 'Algorithm',
                    screenSubText: 'Every user is properly vetted to ensure you never match with bots'),
                OnboardingSlide(
                    imagePath: onboardingGirl2,
                    screenText: 'Matches',
                    screenSubText:
                        'We match you with users of similar interests'),
                OnboardingSlide(
                    imagePath: onboardingGirl3,
                    screenText: 'Premium',
                    screenSubText:
                        'Sign up today and enjoy one month of Premium'),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.75),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect:  WormEffect(
                          dotHeight: 13,
                          dotWidth: 13,
                          spacing: 4.5,
                          dotColor: Colors.black.withOpacity(0.35),
                          activeDotColor: const Color(0xFFE94057)),
                      onDotClicked: (index) => _controller.animateToPage(index,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeIn),
                    ),
                    onLastPage
                        ? GestureDetector(
                            onTap: () async {
                              final navigator = Navigator.of(context);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('showHome', true);
                              navigator
                                  .push(MaterialPageRoute(builder: (context) {
                                return const LandingScreen();
                              }));
                            },
                            child: OnboardingButton(
                                text: 'Done', isLastPage: onLastPage),
                          )
                        : GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: OnboardingButton(
                                text: 'Next', isLastPage: onLastPage),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
