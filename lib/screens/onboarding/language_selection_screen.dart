import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'pt';

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      currentStep: 1,
      icon: Icons.language,
      title: _selectedLanguage == 'pt'
          ? 'Escolha seu idioma'
          : 'Choose your language',
      subtitle: _selectedLanguage == 'pt'
          ? 'Um passo de cada vez.'
          : 'One step at a time.',
      buttonLabel: _selectedLanguage == 'pt' ? 'Continuar' : 'Continue',
      onContinue: () {
        context
            .read<UserProvider>()
            .updateConfiguration(language: _selectedLanguage);
        Navigator.pushNamed(context, '/onboarding/pet-name');
      },
      child: Column(
        children: [
          _LanguageOption(
            title: 'Portugu\u00eas',
            subtitle: 'Brasil',
            code: 'BR',
            isSelected: _selectedLanguage == 'pt',
            onTap: () => setState(() => _selectedLanguage = 'pt'),
          ),
          const SizedBox(height: 16),
          _LanguageOption(
            title: 'English',
            subtitle: 'United States',
            code: 'US',
            isSelected: _selectedLanguage == 'en',
            onTap: () => setState(() => _selectedLanguage = 'en'),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OnboardingOption(
      isSelected: isSelected,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style:
                      const TextStyle(fontSize: 16, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          Text(
            code,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.currentStep,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.buttonLabel,
    required this.onContinue,
    this.showBack = false,
  });

  final int currentStep;
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;
  final String buttonLabel;
  final VoidCallback onContinue;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 44,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OnboardingProgress(currentStep: currentStep),
                          const SizedBox(height: 40),
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: .10),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              icon,
                              color: AppColors.primary,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 42),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 34,
                              height: 1.05,
                              fontWeight: FontWeight.w900,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: 36),
                          child,
                          const Spacer(),
                          const SizedBox(height: 24),
                          if (showBack) ...[
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Voltar'),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton(
                              onPressed: onContinue,
                              child: Text(
                                buttonLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        final isDone = index < currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == 3 ? 0 : 10),
            height: 6,
            decoration: BoxDecoration(
              color: isDone ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}

class OnboardingOption extends StatelessWidget {
  const OnboardingOption({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.primary.withValues(alpha: .04)
          : AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2 : 1.5,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: .10),
                      blurRadius: 26,
                      offset: const Offset(0, 14),
                    ),
                  ]
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
