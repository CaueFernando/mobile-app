import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pet_model.dart';
import '../../providers/pet_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../dashboard_screen.dart';
import 'language_selection_screen.dart';

class PetNameScreen extends StatefulWidget {
  const PetNameScreen({super.key});

  @override
  State<PetNameScreen> createState() => _PetNameScreenState();
}

class _PetNameScreenState extends State<PetNameScreen> {
  final _controller = TextEditingController(text: 'Manuel');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      currentStep: 2,
      icon: Icons.pets,
      title: 'Bem-vindo!',
      subtitle: 'Vamos preparar sua jornada para parar de fumar.',
      buttonLabel: 'Continuar',
      showBack: true,
      onContinue: () {
        if (!_formKey.currentState!.validate()) return;

        final petName = _controller.text.trim();
        context.read<UserProvider>().updateConfiguration(petName: petName);
        context.read<PetProvider>().setPetName(petName);
        Navigator.pushNamed(context, '/onboarding/smoking-type');
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE3D1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: CustomPaint(
                painter: DogPainter(
                  stage: PetStage.puppy,
                  mood: PetMood.happy,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Como voc\u00ea quer chamar seu pet?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Manuel',
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
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              validator: (value) {
                final name = value?.trim() ?? '';
                if (name.isEmpty) return 'Digite um nome para o pet';
                if (name.length > 20) return 'Use ate 20 caracteres';
                return null;
              },
              textCapitalization: TextCapitalization.words,
              maxLength: 20,
            ),
          ],
        ),
      ),
    );
  }
}
