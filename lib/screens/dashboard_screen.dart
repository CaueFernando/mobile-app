import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pet_provider.dart';
import '../utils/constants.dart';
import '../widgets/stat_card.dart';
import '../widgets/action_button.dart';
import '../widgets/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<PetProvider>(
          builder: (context, petProvider, _) {
            final pet = petProvider.pet;

            return Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Bem-vindo de volta!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSizes.paddingSM),
                  Text(
                    'Seu pet ${pet.name} está feliz com você!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSizes.paddingLG),

                  // Pet Visualization (placeholder - será substituído por Flame)
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusLG),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '🐕',
                            style: TextStyle(fontSize: 80),
                          ),
                          const SizedBox(height: AppSizes.paddingMD),
                          Text(
                            pet.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall,
                          ),
                          Text(
                            _getPetStageName(pet.stage),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingLG),

                  // Stats Grid
                  GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: AppSizes.paddingMD,
                    crossAxisSpacing: AppSizes.paddingMD,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StatCard(
                        title: AppTexts.daysWithoutNicotine,
                        value: '${pet.daysWithoutNicotine}',
                        icon: Icons.calendar_today,
                        backgroundColor:
                            AppColors.success.withOpacity(0.1),
                      ),
                      StatCard(
                        title: AppTexts.moneySaved,
                        value: '\$${pet.moneySaved.toStringAsFixed(2)}',
                        icon: Icons.attach_money,
                        backgroundColor: AppColors.warning.withOpacity(0.1),
                      ),
                      StatCard(
                        title: AppTexts.vcoinsBalance,
                        value: '${pet.vcoins}',
                        icon: Icons.star,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingLG),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: AppTexts.addPuff,
                          icon: Icons.cloud,
                          onPressed: () {
                            petProvider.updateVCoins(1);
                            petProvider.updateHappiness(5);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('✅ Bom trabalho! +1 VCoin'),
                              ),
                            );
                          },
                          backgroundColor: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingMD),
                      Expanded(
                        child: ActionButton(
                          label: AppTexts.addCigarette,
                          icon: Icons.smoking_rooms,
                          onPressed: () {
                            petProvider.updateHappiness(-10);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('⚠️ O pet ficou triste...'),
                              ),
                            );
                          },
                          backgroundColor: AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMD),

                  // Secondary Actions
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: AppTexts.hadCraving,
                          icon: Icons.favorite,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    '💪 Vontade registrada! Você consegue!'),
                              ),
                            );
                          },
                          backgroundColor: AppColors.info,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingMD),
                      Expanded(
                        child: ActionButton(
                          label: AppTexts.emergency,
                          icon: Icons.warning,
                          onPressed: () {
                            _showEmergencyDialog(context);
                          },
                          backgroundColor: AppColors.danger,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingMD),
                      Expanded(
                        child: ActionButton(
                          label: AppTexts.share,
                          icon: Icons.share,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    '📤 Progresso compartilhado!'),
                              ),
                            );
                          },
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingXL),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() => _currentPageIndex = index);
        },
      ),
    );
  }

  String _getPetStageName(PetStage stage) {
    const stageNames = {
      PetStage.newborn: 'Recém-nascido 👶',
      PetStage.puppy: 'Filhote 🐶',
      PetStage.young: 'Jovem 🐕',
      PetStage.adult: 'Adulto 💪',
      PetStage.mature: 'Maduro 👴',
      PetStage.elderly: 'Idoso 🧓',
    };
    return stageNames[stage] ?? 'Desconhecido';
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🆘 Emergência'),
        content: const Text(
          'Se você está em uma situação de crise, por favor contate:\n\n'
          '📞 Disque 188 - CVV (Centro de Valorização da Vida)',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }
}
