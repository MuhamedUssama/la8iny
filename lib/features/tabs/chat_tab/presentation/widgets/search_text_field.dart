import 'package:flutter/material.dart';
import 'package:la8iny/core/utils/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  const new({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: true,
      cursorColor: AppColors.primaryTeal,
      cursorRadius: const Radius.circular(16),
      keyboardType: .text,
      textInputAction: .search,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.fieldText,
      ),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: 'Search Users...',
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.hintText,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.primaryTeal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryTeal, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryTeal, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryTeal, width: 2),
        ),
      ),
    );
  }
}
