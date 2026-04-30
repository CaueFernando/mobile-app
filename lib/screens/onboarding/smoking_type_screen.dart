import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import 'language_selection_screen.dart';

class SmokingTypeScreen extends StatefulWidget {
  const SmokingTypeScreen({super.key});

  @override
  State<SmokingTypeScreen> createState() => _SmokingTypeScreenState();
}

class _SmokingTypeScreenState extends State<SmokingTypeScreen> {
  SmokingType _selectedType = SmokingType.vape;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      currentStep: 3,
      icon: Icons.favorite_border,
      title: 'O que voc\u00ea usa?',
      subtitle: 'Vamos calcular quanto voc\u00ea vai economizar.',
      buttonLabel: 'Continuar',
      showBack: true,
      onContinue: () {
        context
            .read<UserProvider>()
            .updateConfiguration(smokingType: _selectedType);
        Navigator.pushNamed(context, '/onboarding/usage-config');
      },
      child: Column(
        children: [
          _SmokingTypeOption(
            title: 'Vape',
            icon: Icons.cloud,
            isSelected: _selectedType == SmokingType.vape,
            onTap: () => setState(() => _selectedType = SmokingType.vape),
          ),
          const SizedBox(height: 16),
          _SmokingTypeOption(
            title: 'Cigarro',
            icon: Icons.smoking_rooms,
            isSelected: _selectedType == SmokingType.cigarette,
            onTap: () => setState(() => _selectedType = SmokingType.cigarette),
          ),
          const SizedBox(height: 16),
          _SmokingTypeOption(
            title: 'Ambos',
            icon: Icons.smoke_free,
            isSelected: _selectedType == SmokingType.both,
            onTap: () => setState(() => _selectedType = SmokingType.both),
          ),
        ],
      ),
    );
  }
}

class _SmokingTypeOption extends StatelessWidget {
  const _SmokingTypeOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OnboardingOption(
      isSelected: isSelected,
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const Spacer(),
          Icon(icon,
              color: isSelected ? AppColors.primary : AppColors.textLight),
        ],
      ),
    );
  }
}
