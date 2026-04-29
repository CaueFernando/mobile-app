import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Shop'),
      ),
      body: const Center(
        child: Text('🛍️ Tela de Shop - Em Desenvolvimento'),
      ),
    );
  }
}
