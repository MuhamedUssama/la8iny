import 'package:flutter/material.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/utils/app_colors.dart';

class ChatTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: AppColors.darkTeal,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('Chat App', style: TextStyle(fontWeight: .bold)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.searchScreen);
            },
            icon: const Icon(Icons.search_rounded, size: 28),
          ),
        ],
      ),
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
