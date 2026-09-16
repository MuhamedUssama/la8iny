import 'package:flutter/material.dart';
import 'package:la8iny/core/utils/app_colors.dart';

class ChatTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Text(
          'Chats',
          style: TextStyle(
            color: AppColors.darkTeal,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
