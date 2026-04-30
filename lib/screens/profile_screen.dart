import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pet_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final petProvider = context.watch<PetProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('SteptoStop', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          const Text('One step at a time. Um passo de cada vez.'),
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
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login planejado',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  SizedBox(height: 8),
                  Text(
                      'Google, Apple e Email serao conectados a uma camada segura de autenticacao.'),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('Google')),
                      Chip(label: Text('Apple')),
                      Chip(label: Text('Email')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: petProvider.logNicotineFreeDay,
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
}
