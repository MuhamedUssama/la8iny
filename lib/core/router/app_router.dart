import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/features/auth/presentation/screens/login_screen.dart';
import 'package:la8iny/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:la8iny/features/home/presentation/screens/home_screen.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/screens/chat_screen.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/screens/search_screen.dart';

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

      case RouteNames.searchScreen:
        return MaterialPageRoute(
          builder: (context) {
            final chatCubit = settings.arguments as ChatCubit;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => GetIt.I<SearchBloc>()),
                BlocProvider.value(value: chatCubit),
              ],
              child: const SearchScreen(),
            );
          },
          settings: settings,
        );

      case RouteNames.chatScreen:
        return MaterialPageRoute(builder: (context) => const ChatScreen());

      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}
