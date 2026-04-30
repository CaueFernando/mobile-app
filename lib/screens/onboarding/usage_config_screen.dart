import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import 'language_selection_screen.dart';

class UsageConfigScreen extends StatefulWidget {
  const UsageConfigScreen({super.key});

  @override
  State<UsageConfigScreen> createState() => _UsageConfigScreenState();
}

class _UsageConfigScreenState extends State<UsageConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vapePriceController = TextEditingController(text: '50');
  final _vapeDurationController = TextEditingController(text: '7');
  final _cigarettePackPriceController = TextEditingController(text: '10');
  final _dailyCigarettesController = TextEditingController(text: '10');

  @override
  void dispose() {
    _vapePriceController.dispose();
    _vapeDurationController.dispose();
    _cigarettePackPriceController.dispose();
    _dailyCigarettesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final smokingType = userProvider.user?.smokingType ?? SmokingType.vape;
    final showVape =
        smokingType == SmokingType.vape || smokingType == SmokingType.both;
    final showCigarette =
        smokingType == SmokingType.cigarette || smokingType == SmokingType.both;

    return OnboardingScaffold(
      currentStep: 4,
      icon: Icons.account_balance_wallet_outlined,
      title: 'Quanto voc\u00ea gasta?',
      subtitle: 'Vamos calcular quanto voc\u00ea vai economizar.',
      buttonLabel: 'Come\u00e7ar jornada',
      showBack: true,
      onContinue: () {
        if (!_formKey.currentState!.validate()) return;

        final vapePrice = _parseDouble(_vapePriceController.text);
        final vapeDuration = _parseInt(_vapeDurationController.text);
        final packPrice = _parseDouble(_cigarettePackPriceController.text);
        final dailyCigarettes = _parseInt(_dailyCigarettesController.text);

        context.read<UserProvider>().updateConfiguration(
              vapePrice: vapePrice,
              vapeDurationDays: vapeDuration,
              cigarettePackPrice: packPrice,
              dailyCigarettes: dailyCigarettes,
              dailyUsage: showCigarette ? dailyCigarettes : vapeDuration,
            );
        context.read<UserProvider>().markAsConfigured();
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (showVape)
              _ConfigCard(
                title: 'VAPE',
                children: [
                  _MoneyField(
                    controller: _vapePriceController,
                    label: 'Pre\u00e7o do vape (R\$)',
                  ),
                  const SizedBox(height: 14),
                  _NumberField(
                    controller: _vapeDurationController,
                    label: 'Dura\u00e7\u00e3o estimada (dias)',
                  ),
                ],
              ),
            if (showVape && showCigarette) const SizedBox(height: 20),
            if (showCigarette)
              _ConfigCard(
                title: 'CIGARRO',
                children: [
                  _MoneyField(
                    controller: _cigarettePackPriceController,
                    label: 'Pre\u00e7o do ma\u00e7o (R\$)',
                  ),
                  const SizedBox(height: 14),
                  _NumberField(
                    controller: _dailyCigarettesController,
                    label: 'Cigarros por dia',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  double _parseDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  }

  int _parseInt(String value) {
    return int.tryParse(value) ?? 0;
  }
}

class _ConfigCard extends StatelessWidget {
  const _ConfigCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textLight,
              fontWeight: FontWeight.w900,
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return _OnboardingTextField(
      controller: controller,
      label: label,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        final parsed = double.tryParse((value ?? '').replaceAll(',', '.'));
        if (parsed == null || parsed <= 0) return 'Digite um valor valido';
        return null;
      },
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return _OnboardingTextField(
      controller: controller,
      label: label,
      keyboardType: TextInputType.number,
      validator: (value) {
        final parsed = int.tryParse(value ?? '');
        if (parsed == null || parsed <= 0) return 'Digite um numero valido';
        return null;
      },
    );
  }
}

class _OnboardingTextField extends StatelessWidget {
  const _OnboardingTextField({
    required this.controller,
    required this.label,
    required this.keyboardType,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
