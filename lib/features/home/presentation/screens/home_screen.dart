import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/screens/chat_tab.dart';
import 'package:la8iny/features/tabs/profile_tab/presentation/screens/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(create: (_) => GetIt.I<ChatCubit>(), child: const ChatTab()),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildNavigationBar() {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      backgroundColor: AppColors.onPrimary,
      indicatorColor: AppColors.softTeal,
      elevation: 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: AppColors.secondaryText,
          ),
          selectedIcon: Icon(
            Icons.chat_bubble_rounded,
            color: AppColors.primaryTeal,
          ),
          label: 'Chats',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
            color: AppColors.secondaryText,
          ),
          selectedIcon: Icon(
            Icons.person_rounded,
            color: AppColors.primaryTeal,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
