import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profile', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.surface,
                  child: Icon(Icons.person, size: 60, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final email = state is Authenticated ? state.email : 'Unknown User';
                    return Text(
                      email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    );
                  },
                ),
                const SizedBox(height: 48),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
                        title: const Text('My Orders', style: TextStyle(color: AppColors.textPrimary)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
                        onTap: () {},
                      ),
                      const Divider(height: 1, color: Colors.black12),
                      ListTile(
                        leading: const Icon(Icons.settings_outlined, color: AppColors.primary),
                        title: const Text('Settings', style: TextStyle(color: AppColors.textPrimary)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is AuthLoading 
                          ? null 
                          : () => context.read<AuthBloc>().add(LogoutRequested()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: state is AuthLoading
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
