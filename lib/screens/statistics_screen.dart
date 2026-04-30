import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pet_provider.dart';
import '../utils/constants.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, _) {
        final pet = petProvider.pet;
        return Scaffold(
          appBar: AppBar(title: const Text('Estat\u00edsticas')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatRow(
                  label: 'Total puffs hoje',
                  value: '${petProvider.dailyPuffs}',
                  color: AppColors.primary),
              _StatRow(
                  label: 'Total cigarros hoje',
                  value: '${petProvider.dailyCigarettes}',
                  color: AppColors.secondary),
              _StatRow(
                  label: 'Vontades registradas',
                  value: '${petProvider.cravingsToday}',
                  color: AppColors.warning),
              _StatRow(
                  label: 'Maior sequencia',
                  value: '${pet.daysWithoutNicotine} dias',
                  color: AppColors.success),
              _StatRow(
                  label: 'Dinheiro economizado',
                  value: '\$${pet.moneySaved.toStringAsFixed(0)}',
                  color: AppColors.info),
              const SizedBox(height: 18),
              Text('Padroes de vontade',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const _Bar(label: 'Stress', value: .72),
              const _Bar(label: 'Ansiedade', value: .54),
              const _Bar(label: 'Tedio', value: .36),
              const _Bar(label: 'Social', value: .22),
            ],
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow(
      {required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: color,
            child: const Icon(Icons.insights, color: Colors.white)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        trailing: Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(label)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 12,
                color: AppColors.primary,
                backgroundColor: AppColors.border,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
