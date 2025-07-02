import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: screenHeight * 0.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff2a0000), Color(0xffb71c1c)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Image.asset('assets/logo_step_over.png', width: 180.0),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Teks sambutan
          Text(
            'WELCOME',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Where Every Step Defines You',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 40),

          // Tombol Login
          _buildAuthButton(
            screenWidth: screenWidth,
            label: 'Login',
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          const SizedBox(height: 16),

          // Tombol Sign Up
          _buildAuthButton(
            screenWidth: screenWidth,
            label: 'Sign Up',
            onPressed: () {
              print('Sign Up button pressed');
            },
          ),

          const Spacer(),

          // Tombol Continue with Google
          _buildGoogleButton(screenWidth),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget helper untuk tombol Login dan Sign Up
  Widget _buildAuthButton({
    required double screenWidth,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfffdd835),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // Widget helper untuk tombol Google
  Widget _buildGoogleButton(double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          print('Continue with Google pressed');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfffdd835),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        icon: Image.asset('assets/logo_google.png', height: 22.0),
        label: Text(
          'Continue With Google',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
