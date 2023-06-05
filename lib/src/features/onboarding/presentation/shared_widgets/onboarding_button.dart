
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final bool isLastPage;
  final String text;
  const OnboardingButton({
    super.key,
    required this.text, required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 75,
      decoration: BoxDecoration(
        color: isLastPage ? Colors.green : const Color(0xFF0E0E52),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}