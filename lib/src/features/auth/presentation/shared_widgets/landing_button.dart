import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingButton extends StatelessWidget {
  final String text;
  const LandingButton({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 135,
      decoration: BoxDecoration(
        color: const Color(0xFFE94057),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(text, style: GoogleFonts.montserrat(
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
        ),),
      ),
    );
  }
}
