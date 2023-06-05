import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSlide extends StatelessWidget {
  final String screenText;
  final String screenSubText;
  final String imagePath;

  const OnboardingSlide(
      {super.key, required this.screenText, required this.imagePath, required this.screenSubText});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const SizedBox(
            height: 8.5,
          ),
          //image
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(imagePath), fit: BoxFit.cover),
              ),
            ),
          ),

          //text
          Container(
            padding: const EdgeInsets.all(5),
            alignment: const Alignment(0, -0.75),
            child: Text(
              textAlign: TextAlign.start,
              screenText,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24.5,
                  color: Color(0xFFE94057),
                  fontWeight: FontWeight.w700),
              )
            ),
          ),

           //subtext
          Container(
            padding: const EdgeInsets.all(10),
            alignment: const Alignment(0, -0.75),
            child: Text(
              textAlign: TextAlign.start,
              screenSubText,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 17.85,
                  color: Color(0xFF323755),
                  ),
              )
            ),
          ),
        ],
      )),
    );
  }
}


// Stack(children: [
//           Container(
//             padding: const EdgeInsets.all(5),
//             constraints: const BoxConstraints.expand(),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage(imagePath), fit: BoxFit.cover),
//             ),
//           ),
          // Container(
          //   padding: const EdgeInsets.all(5),
          //   alignment: const Alignment(0, -0.75),
          //   child: Text(
          //     textAlign: TextAlign.start,
          //     screenText,
          //     style: const TextStyle(
          //         fontSize: 25,
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold),
          //   ),
//           )
//         ]),