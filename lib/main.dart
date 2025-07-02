import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/shopping_cart_screen.dart';
import 'screens/payment_process_screen.dart';
import 'screens/order_success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Over',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/dashboard':
            return MaterialPageRoute(builder: (_) => const DashboardScreen());
          case '/cart':
            final cartItems = settings.arguments as List<Map<String, String>>;
            return MaterialPageRoute(
              builder: (_) => ShoppingCartScreen(cartItems: cartItems),
            );
          case '/payment':
            final args = settings.arguments as Map<String, dynamic>;
            final subtotal = args['subtotal'] as double;
            final cartItems = args['cartItems'] as List<Map<String, String>>;
            return MaterialPageRoute(
              builder:
                  (_) => PaymentProcessScreen(
                    subtotal: subtotal,
                    cartItems: cartItems,
                  ),
            );
          case '/order_success':
            final cartItems = settings.arguments as List<Map<String, String>>;
            return MaterialPageRoute(
              builder: (_) => OrderSuccessScreen(cartItems: cartItems),
            );
          default:
            return MaterialPageRoute(
              builder:
                  (_) => const Scaffold(
                    body: Center(child: Text('Page not found')),
                  ),
            );
        }
      },
    );
  }
}
