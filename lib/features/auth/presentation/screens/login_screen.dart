import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/core/utils/app_validator.dart';
import 'package:la8iny/core/widgets/custom_text_field.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_state.dart';
import 'package:la8iny/features/auth/presentation/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLoggedIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome ${state.user?.fullname}')),
          );

          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
        } else if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.waving_hand_rounded,
                      color: AppColors.primaryTeal,
                      size: 42,
                    ),
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        color: AppColors.darkTeal,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: _emailController,
                      keyboardType: .emailAddress,
                      textInputAction: .next,
                      hintText: 'Enter email address',
                      prefixIcon: Icons.email_outlined,
                      labelText: 'Email',
                      validator: AppValidator.emailValidator,
                    ),

                    CustomTextField(
                      controller: _passwordController,
                      keyboardType: .visiblePassword,
                      textInputAction: .done,
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock,
                      labelText: 'Password',
                      validator: AppValidator.passwordValidator,
                      isPassword: true,
                    ),

                    const SizedBox(height: 24),

                    LoginButton(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteNames.registerScreen,
                        );
                      },
                      child: const Text(
                        "Don't have an account?",
                        style: TextStyle(color: AppColors.darkTeal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
