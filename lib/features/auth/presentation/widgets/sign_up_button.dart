import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/utils/app_colors.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const new({
    super.key,
    required this.emailController,
    required this.formKey,
    required this.nameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          log('Name: ${nameController.text}');
          log('Email: ${emailController.text}');
          log('Password: ${passwordController.text}');

          context.read<AuthCubit>().signUp(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        minimumSize: const Size.fromHeight(52),
      ),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) {
          return current.isLoading || current.isLoggedIn || current.isError;
        },
        builder: (context, state) {
          return state.isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.onPrimary,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'SignUp',
                  style: TextStyle(fontSize: 20, fontWeight: .w500),
                );
        },
      ),
    );
  }
}
