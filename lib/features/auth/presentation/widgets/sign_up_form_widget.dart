import 'package:flutter/material.dart';
import 'package:la8iny/core/utils/app_validator.dart';
import 'package:la8iny/core/widgets/custom_text_field.dart';

class SignUpFormWidget extends StatelessWidget {
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
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          CustomTextField(
            controller: nameController,
            keyboardType: .name,
            textInputAction: .next,
            hintText: 'Enter full name',
            prefixIcon: Icons.person,
            labelText: 'Name',
            validator: AppValidator.nameVaidator,
          ),

          CustomTextField(
            controller: emailController,
            keyboardType: .emailAddress,
            textInputAction: .next,
            hintText: 'Enter email address',
            prefixIcon: Icons.email_outlined,
            labelText: 'Email',
            validator: AppValidator.emailValidator,
          ),

          CustomTextField(
            controller: passwordController,
            keyboardType: .visiblePassword,
            textInputAction: .done,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock,
            labelText: 'Password',
            validator: AppValidator.passwordValidator,
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
