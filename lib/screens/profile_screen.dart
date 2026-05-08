import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pet_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final petProvider = context.watch<PetProvider>();
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final photoUrl = user?.photoUrl;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.primary.withValues(alpha: .12),
                    foregroundImage: (photoUrl == null || photoUrl.isEmpty)
                        ? null
                        : NetworkImage(photoUrl),
                    child: Text(
                      _initialsFor(user?.name),
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? AppTexts.appName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'Conta local',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textLight,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        const Chip(
                          avatar: Icon(Icons.verified, size: 18),
                          label: Text('Google conectado'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: petProvider.pet.name,
            decoration: const InputDecoration(
              labelText: 'Nome do pet',
              border: OutlineInputBorder(),
            ),
            onFieldSubmitted: petProvider.setPetName,
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            value: themeProvider.isDarkMode,
            onChanged: themeProvider.setDarkMode,
            title: const Text('Modo escuro'),
            secondary: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Conta',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  const Text(
                      'Seu perfil Google esta conectado a esta jornada.'),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: userProvider.isLoading
                        ? null
                        : () async {
                            await userProvider.logout();
                            if (!context.mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => false,
                            );
                          },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair da conta'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              final dailyCost =
                  context.read<UserProvider>().user?.estimatedDailyCost ?? 0;
              petProvider.logNicotineFreeDay(moneySavedDelta: dailyCost);
            },
            icon: const Icon(Icons.check_circle),
            label: const Text('Simular dia sem nicotina (+10 VCoins)'),
          ),
          TextButton(
            onPressed: petProvider.resetPet,
            child: const Text('Resetar demo',
                style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  String _initialsFor(String? name) {
    final cleanName = name?.trim();
    if (cleanName == null || cleanName.isEmpty) return 'S';

    final parts = cleanName.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();

    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}
