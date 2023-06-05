import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FancyButton extends StatelessWidget {
  final String text;
  const FancyButton({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
