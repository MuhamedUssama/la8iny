import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_state.dart';
import 'package:la8iny/features/auth/presentation/widgets/sign_up_button.dart';
import 'package:la8iny/features/auth/presentation/widgets/sign_up_form_widget.dart';

class SignUpScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Form(
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.isLoggedIn) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Welcome ${state.user?.fullname}')),
                  );

                  Navigator.pushReplacementNamed(
                    context,
                    RouteNames.loginScreen,
                  );
                } else if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage ?? "Error")),
                  );
                }
              },
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
                    'Sign Up to continue',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SignUpFormWidget(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 24),
                  SignUpButton(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.loginScreen,
                      );
                    },
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(color: AppColors.darkTeal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
