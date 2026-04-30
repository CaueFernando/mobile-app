import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pet_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, _) {
        final events = petProvider.events;
        return Scaffold(
          appBar: AppBar(title: const Text('Hist\u00f3rico')),
          body: events.isEmpty
              ? const Center(child: Text('Nenhum evento registrado ainda.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.timeline),
                      title: Text(events[index]),
                      subtitle: const Text('Registrado agora'),
                    );
                  },
                ),
        );
      },
    );
  }
}
