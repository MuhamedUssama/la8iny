import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_state.dart';

class ProfileTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.loginScreen,
            (route) => false,
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final user = state.user;
                  if (user == null) return const SizedBox();

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          user.fullname[0].toUpperCase(),
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user.fullname,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implement notifications settings
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Privacy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implement privacy settings
                },
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: context.read<AuthCubit>().logout,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return state.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Logout');
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
