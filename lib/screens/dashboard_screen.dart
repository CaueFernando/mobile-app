import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pet_model.dart';
import '../providers/pet_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, _) {
        final pet = petProvider.pet;

        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              children: [
                _Header(pet: pet),
                const SizedBox(height: 14),
                _CleanDaysCard(pet: pet),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _MiniStatCard(
                        icon: Icons.attach_money,
                        iconColor: AppColors.success,
                        value: '\$${pet.moneySaved.toStringAsFixed(0)}',
                        label: AppTexts.t('moneySaved'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MiniStatCard(
                        icon: Icons.monetization_on,
                        iconColor: AppColors.gold,
                        value: '${pet.vcoins}',
                        label: AppTexts.t('vcoins'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _PetStage(
                  pet: pet,
                  dailyPuffs: petProvider.dailyPuffs,
                  dailyCigarettes: petProvider.dailyCigarettes,
                ),
                const SizedBox(height: 12),
                _PrimaryActions(petProvider: petProvider),
                const SizedBox(height: 10),
                _SupportAction(
                  color: const Color(0xFFFFF3CC),
                  icon: Icons.psychology_alt,
                  title: AppTexts.t('hadCraving'),
                  subtitle: 'Registre sua vontade e ganhe +2 VCoins',
                  onTap: () => _showCravingSheet(context, petProvider),
                ),
                const SizedBox(height: 10),
                _SupportAction(
                  color: const Color(0xFFFFD8D1),
                  icon: Icons.warning_amber_rounded,
                  title: AppTexts.t('emergency'),
                  subtitle: 'Preciso de ajuda agora',
                  onTap: () => _showEmergencyDialog(context),
                ),
                const SizedBox(height: 10),
                _SupportAction(
                  color: AppColors.info,
                  foreground: AppColors.white,
                  icon: Icons.share,
                  title: AppTexts.t('share'),
                  subtitle: 'Compartilhar nas redes sociais',
                  onTap: () => _showSharePreview(context, pet),
                ),
                const SizedBox(height: 16),
                _EvolutionTimeline(currentStage: pet.stage),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCravingSheet(BuildContext context, PetProvider petProvider) {
    var intensity = 3;
    var reason = 'Stress';

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registrar vontade',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text('Intensidade: $intensity/5'),
                  Slider(
                    value: intensity.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: '$intensity',
                    onChanged: (value) =>
                        setState(() => intensity = value.round()),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      'Stress',
                      'Ansiedade',
                      'Tedio',
                      'Habito',
                      'Social',
                      'Outro'
                    ]
                        .map(
                          (item) => ChoiceChip(
                            label: Text(item),
                            selected: reason == item,
                            onSelected: (_) => setState(() => reason = item),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        petProvider.logCraving(
                            intensity: intensity, reason: reason);
                        context.read<UserProvider>().incrementCravings();
                        Navigator.pop(context);
                      },
                      child: const Text('Salvar e ganhar +2 VCoins'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emerg\u00eancia'),
        content: const Text(
          'Pare por 60 segundos.\n\n'
          '1. Inspire por 4 segundos.\n'
          '2. Segure por 4 segundos.\n'
          '3. Solte o ar por 6 segundos.\n\n'
          'A vontade passa como uma onda. Voce so precisa atravessar este minuto.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Estou no controle'),
          ),
        ],
      ),
    );
  }

  void _showSharePreview(BuildContext context, Pet pet) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8FF),
                borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Text(
                    '${pet.daysWithoutNicotine} Dias sem nicotina',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text('${pet.vcoins} VCoins'),
                  SizedBox(
                    height: 170,
                    child: CustomPaint(
                      painter:
                          DogPainter(stage: pet.stage, mood: PetMood.proud),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  Text('Seu pet ${pet.name} esta orgulhoso de voce!'),
                  const SizedBox(height: 8),
                  const Text(
                    '#SteptoStop',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        const Expanded(
          child: Text(
            'Dashboard',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
        ),
        Stack(
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_none)),
            Positioned(
              right: 9,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: AppColors.danger, shape: BoxShape.circle),
                child: const Text('3',
                    style: TextStyle(color: Colors.white, fontSize: 9)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CleanDaysCard extends StatelessWidget {
  const _CleanDaysCard({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return _Surface(
      child: Row(
        children: [
          Text(
            '${pet.daysWithoutNicotine}',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 56,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppTexts.t('daysClean'),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  AppTexts.t('keepGoing'),
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 72,
            height: 72,
            child: CircularProgressIndicator(
              value: (pet.daysWithoutNicotine % 7) / 7,
              strokeWidth: 5,
              color: AppColors.primary,
              backgroundColor: AppColors.border,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return _Surface(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: iconColor,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w900)),
                Text(label,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PetStage extends StatelessWidget {
  const _PetStage({
    required this.pet,
    required this.dailyPuffs,
    required this.dailyCigarettes,
  });

  final Pet pet;
  final int dailyPuffs;
  final int dailyCigarettes;

  @override
  Widget build(BuildContext context) {
    return _Surface(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        child: Stack(
          children: [
            Container(
              height: 310,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF8E8), Color(0xFFE3F5D6)],
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 84,
              child: Icon(Icons.local_florist,
                  size: 72, color: AppColors.primary.withValues(alpha: .55)),
            ),
            Positioned(
              right: 18,
              bottom: 42,
              child: Icon(Icons.sports_baseball,
                  size: 28, color: AppColors.secondary.withValues(alpha: .8)),
            ),
            SizedBox(
              height: 310,
              child: CustomPaint(
                painter: DogPainter(stage: pet.stage, mood: pet.mood),
                child: const SizedBox.expand(),
              ),
            ),
            Positioned(
              right: 14,
              top: 28,
              child: Container(
                width: 92,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  '${pet.name} esta\n${_moodText(pet.mood)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              child: _StagePill(stage: _stageText(pet.stage)),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: _StagePill(
                  stage: '$dailyPuffs puffs | $dailyCigarettes cigarros'),
            ),
          ],
        ),
      ),
    );
  }

  String _moodText(PetMood mood) {
    return switch (mood) {
      PetMood.happy => 'feliz',
      PetMood.excited => 'animado',
      PetMood.sad => 'triste',
      PetMood.sleeping => 'dormindo',
      PetMood.proud => 'orgulhoso',
    };
  }

  String _stageText(PetStage stage) {
    return switch (stage) {
      PetStage.newborn => 'Recem-nascido',
      PetStage.puppy => 'Filhote',
      PetStage.young => 'Jovem',
      PetStage.adult => 'Adulto',
      PetStage.mature => 'Maduro',
      PetStage.elder => 'Idoso',
    };
  }
}

class _StagePill extends StatelessWidget {
  const _StagePill({required this.stage});

  final String stage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Text(stage,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
    );
  }
}

class _PrimaryActions extends StatelessWidget {
  const _PrimaryActions({required this.petProvider});

  final PetProvider petProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _BigActionButton(
            color: AppColors.primary,
            icon: Icons.cloud,
            title: AppTexts.t('addPuff'),
            subtitle: 'Vape',
            onTap: () {
              petProvider.logPuff();
              context.read<UserProvider>().incrementPuffs();
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _BigActionButton(
            color: AppColors.secondary,
            icon: Icons.smoking_rooms,
            title: AppTexts.t('addCigarette'),
            subtitle: 'Cigarro',
            onTap: () {
              petProvider.logCigarette();
              context.read<UserProvider>().incrementCigarettes();
            },
          ),
        ),
      ],
    );
  }
}

class _BigActionButton extends StatelessWidget {
  const _BigActionButton({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900)),
                    Text(subtitle,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportAction extends StatelessWidget {
  const _SupportAction({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.foreground = AppColors.text,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 34, color: foreground),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: foreground,
                            fontSize: 16,
                            fontWeight: FontWeight.w900)),
                    Text(subtitle,
                        style: TextStyle(
                          color: foreground.withValues(alpha: .86),
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}

class _EvolutionTimeline extends StatelessWidget {
  const _EvolutionTimeline({required this.currentStage});

  final PetStage currentStage;

  @override
  Widget build(BuildContext context) {
    final stages = [
      ('Recem-nascido', 'Dia 0', PetStage.newborn),
      ('Filhote', '3 dias', PetStage.puppy),
      ('Jovem', '7 dias', PetStage.young),
      ('Adulto', '30 dias', PetStage.adult),
      ('Maduro', '90 dias', PetStage.mature),
      ('Idoso', '365 dias', PetStage.elder),
    ];

    return _Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Evolucao do seu pet',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 12),
          ...stages.map(
            (stage) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(
                    currentStage.index >= stage.$3.index
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: currentStage.index >= stage.$3.index
                        ? AppColors.primary
                        : AppColors.textLight,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(stage.$1,
                          style: const TextStyle(fontWeight: FontWeight.w800))),
                  Text(stage.$2,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Surface extends StatelessWidget {
  const _Surface(
      {required this.child, this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.panelDark : AppColors.panel,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border:
            Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? .25 : .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class DogPainter extends CustomPainter {
  DogPainter({required this.stage, required this.mood});

  final PetStage stage;
  final PetMood mood;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = switch (stage) {
      PetStage.newborn => .62,
      PetStage.puppy => .78,
      PetStage.young => .9,
      PetStage.adult => 1.0,
      PetStage.mature => 1.04,
      PetStage.elder => 1.0,
    };
    final center = Offset(size.width / 2, size.height * .6);
    final fur = Paint()..color = const Color(0xFFFFC94D);
    final furDark = Paint()..color = const Color(0xFFE59B22);
    final cream = Paint()..color = const Color(0xFFFFE6A5);
    final black = Paint()..color = AppColors.black;
    final collar = Paint()..color = AppColors.black;

    canvas.drawOval(
        Rect.fromCenter(
            center: center + Offset(0, 30 * scale),
            width: 178 * scale,
            height: 148 * scale),
        fur);
    canvas.drawOval(
        Rect.fromCenter(
            center: center + Offset(-64 * scale, -18 * scale),
            width: 46 * scale,
            height: 126 * scale),
        furDark);
    canvas.drawOval(
        Rect.fromCenter(
            center: center + Offset(64 * scale, -18 * scale),
            width: 46 * scale,
            height: 126 * scale),
        furDark);
    canvas.drawCircle(center + Offset(0, -56 * scale), 72 * scale, fur);
    canvas.drawOval(
        Rect.fromCenter(
            center: center + Offset(0, -34 * scale),
            width: 92 * scale,
            height: 74 * scale),
        cream);

    final eyeYOffset = mood == PetMood.sad ? -58.0 : -66.0;
    _eye(canvas, center + Offset(-26 * scale, eyeYOffset * scale), scale,
        mood == PetMood.sleeping);
    _eye(canvas, center + Offset(26 * scale, eyeYOffset * scale), scale,
        mood == PetMood.sleeping);
    canvas.drawOval(
        Rect.fromCenter(
            center: center + Offset(0, -42 * scale),
            width: 28 * scale,
            height: 20 * scale),
        black);

    final mouth = Paint()
      ..color = mood == PetMood.sad ? AppColors.black : AppColors.danger
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * scale
      ..strokeCap = StrokeCap.round;
    if (mood == PetMood.sad) {
      canvas.drawArc(
        Rect.fromCenter(
            center: center + Offset(0, -16 * scale),
            width: 42 * scale,
            height: 24 * scale),
        3.35,
        .75,
        false,
        mouth,
      );
    } else {
      canvas.drawArc(
        Rect.fromCenter(
            center: center + Offset(0, -27 * scale),
            width: 42 * scale,
            height: 32 * scale),
        .2,
        2.75,
        false,
        mouth,
      );
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: center + Offset(0, 13 * scale),
            width: 112 * scale,
            height: 20 * scale),
        Radius.circular(10 * scale),
      ),
      collar,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: center + Offset(0, 29 * scale),
            width: 52 * scale,
            height: 25 * scale),
        Radius.circular(5 * scale),
      ),
      Paint()..color = const Color(0xFFEDE9D8),
    );
    canvas.drawCircle(
        center + Offset(-44 * scale, 83 * scale), 22 * scale, furDark);
    canvas.drawCircle(
        center + Offset(44 * scale, 83 * scale), 22 * scale, furDark);
    canvas.drawCircle(
        center + Offset(-70 * scale, 75 * scale), 20 * scale, fur);
    canvas.drawCircle(center + Offset(70 * scale, 75 * scale), 20 * scale, fur);
  }

  void _eye(Canvas canvas, Offset center, double scale, bool sleeping) {
    final black = Paint()..color = AppColors.black;
    if (sleeping) {
      final paint = Paint()
        ..color = AppColors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4 * scale
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
          Rect.fromCenter(
              center: center, width: 24 * scale, height: 12 * scale),
          0,
          3.14,
          false,
          paint);
      return;
    }
    canvas.drawCircle(center, 16 * scale, Paint()..color = Colors.white);
    canvas.drawCircle(center, 10 * scale, black);
    canvas.drawCircle(center + Offset(-4 * scale, -5 * scale), 3 * scale,
        Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant DogPainter oldDelegate) {
    return oldDelegate.stage != stage || oldDelegate.mood != mood;
  }
}
