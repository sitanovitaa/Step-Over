import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoStepOver extends StatelessWidget {
  const LogoStepOver({super.key, this.width = 180.0});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo_step_over.png', width: width),
        const SizedBox(height: 12),
        Text(
          'Your Next Step Forward',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xff6c757d),
          ),
        ),
      ],
    );
  }
}
