import 'package:flutter/material.dart';
import 'package:la8iny/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final String hintText;
  final IconData prefixIcon;
  final String labelText;
  final bool isPassword;

  const new({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    required this.hintText,
    required this.prefixIcon,
    required this.labelText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return TextFormField(
      autocorrect: true,
      controller: widget.controller,
      cursorColor: AppColors.primaryTeal,
      cursorRadius: const Radius.circular(16),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: obscureText,
      validator: widget.validator,
      autovalidateMode: .onUserInteractionIfError,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.fieldText,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.softTeal.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColors.primaryTeal,
          fontWeight: FontWeight.w600,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primaryTeal,
          fontWeight: FontWeight.w700,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.hintText,
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryTeal.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            widget.prefixIcon,
            color: AppColors.primaryTeal,
            size: 21,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                tooltip: obscureText ? 'Show password' : 'Hide password',
                color: AppColors.primaryTeal,
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.tealBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.tealBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.primaryTeal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}
