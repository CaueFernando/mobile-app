import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.pets,
                      color: AppColors.primary,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    AppTexts.appName,
                    style: TextStyle(
                      fontSize: 40,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Entre para manter sua jornada conectada ao seu perfil.',
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.35,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 44),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton.icon(
                      onPressed: userProvider.isLoading
                          ? null
                          : () => _signIn(context),
                      icon: userProvider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        userProvider.isLoading
                            ? 'Entrando...'
                            : 'Entrar com Google',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  if (userProvider.errorMessage != null) ...[
                    const SizedBox(height: 18),
                    Text(
                      userProvider.errorMessage!,
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    final userProvider = context.read<UserProvider>();

    try {
      await userProvider.signInWithGoogle();

      if (!context.mounted) return;

      final route =
          userProvider.isConfigured ? '/main' : '/onboarding/language';
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nao foi possivel entrar com Google agora.'),
        ),
      );
    }
  }
}
