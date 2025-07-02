import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: screenHeight * 0.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff2a0000), Color(0xffb71c1c)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Image.asset('assets/logo_step_over.png', width: 160.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildLoginForm(context, screenWidth),
                  const SizedBox(height: 20),
                  _buildSignUpLink(context),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            _buildGoogleButton(screenWidth),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun form login
  Widget _buildLoginForm(BuildContext context, double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xffb71c1c).withOpacity(0.9),
            const Color(0xffc62828),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Username
          Text(
            'Username',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildTextField(hintText: 'Your Username....'),
          const SizedBox(height: 20),
          // Label Password
          Text(
            'Password',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildTextField(hintText: 'Your Password....', obscureText: true),
          const SizedBox(height: 30),
          // Tombol Login
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfffdd835),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk text field
  Widget _buildTextField({required String hintText, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    );
  }

  // Widget helper untuk link Sign Up
  Widget _buildSignUpLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14),
        children: [
          const TextSpan(text: "Don't have account? "),
          TextSpan(
            text: 'Sign Up',
            style: GoogleFonts.poppins(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    print('Navigate to Sign Up');
                  },
          ),
        ],
      ),
    );
  }

  // Widget helper untuk tombol Google (sama seperti di WelcomeScreen)
  Widget _buildGoogleButton(double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {},
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
