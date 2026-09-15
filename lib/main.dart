import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:la8iny/core/di/service_locator.dart';
import 'package:la8iny/core/router/app_router.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/services/shared_pref_service.dart';
import 'package:la8iny/core/utils/app_constants.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await SharedPrefService.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const La8iny());
}

class La8iny extends StatelessWidget {
  const La8iny({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<AuthCubit>(),
      child: MaterialApp(
        title: 'La8iny Chat App',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: _getInitialRoute(),
      ),
    );
  }
}

String _getInitialRoute() {
  if (SharedPrefService.getString(AppConstants.cacheUserKey) != null) {
    return RouteNames.homeScreen;
  }
  return RouteNames.loginScreen;
}
