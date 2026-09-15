import 'package:flutter/material.dart';

import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/features/auth/presentation/screens/login_screen.dart';
import 'package:la8iny/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:la8iny/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}
