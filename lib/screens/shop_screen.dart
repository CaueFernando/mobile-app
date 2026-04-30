import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pet_provider.dart';
import '../utils/constants.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (name: 'Racao premium', price: 20, icon: Icons.restaurant),
      (name: 'Bolinha azul', price: 30, icon: Icons.sports_baseball),
      (name: 'Caminha macia', price: 45, icon: Icons.bed),
      (name: 'Coleira nova', price: 55, icon: Icons.pets),
      (name: 'Roupa verde', price: 70, icon: Icons.checkroom),
      (name: 'Item raro', price: 120, icon: Icons.diamond),
    ];

    return Consumer<PetProvider>(
      builder: (context, petProvider, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Pet Shop')),
          body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .88,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final canBuy = petProvider.pet.vcoins >= item.price;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            AppColors.primary.withValues(alpha: .12),
                        child: Icon(item.icon, color: AppColors.primary),
                      ),
                      const Spacer(),
                      Text(item.name,
                          style: const TextStyle(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 6),
                      Text('${item.price} VCoins',
                          style: const TextStyle(
                              color: AppColors.gold,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: canBuy
                              ? () =>
                                  petProvider.buyShopItem(item.price, item.name)
                              : null,
                          child: const Text('Comprar'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
