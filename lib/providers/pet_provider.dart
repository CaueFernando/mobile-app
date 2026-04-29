import 'package:flutter/foundation.dart';
import '../models/pet_model.dart';

class PetProvider extends ChangeNotifier {
  Pet _pet = Pet(
    name: 'Puff',
    stage: PetStage.newborn,
    daysWithoutNicotine: 0,
    moneySaved: 0.0,
    vcoins: 0,
    happiness: 80,
    health: 100,
    createdAt: DateTime.now(),
    lastUpdate: DateTime.now(),
  );

  Pet get pet => _pet;

  // Incrementar dias (chamado a cada dia)
  void incrementDays() {
    final newDays = _pet.daysWithoutNicotine + 1;
    _updatePet(_pet.copyWith(daysWithoutNicotine: newDays));
    _updateStage(newDays);
    _notifyListeners();
  }

  // Atualizar dinheiro economizado
  void updateMoneySaved(double amount) {
    _updatePet(_pet.copyWith(moneySaved: _pet.moneySaved + amount));
  }

  // Atualizar VCoins
  void updateVCoins(int amount) {
    final newVCoins = _pet.vcoins + amount;
    _updatePet(_pet.copyWith(vcoins: newVCoins.clamp(0, 999999)));
  }

  // Atualizar felicidade
  void updateHappiness(int amount) {
    final newHappiness = (_pet.happiness + amount).clamp(0, 100);
    _updatePet(_pet.copyWith(happiness: newHappiness));
  }

  // Atualizar saúde
  void updateHealth(int amount) {
    final newHealth = (_pet.health + amount).clamp(0, 100);
    _updatePet(_pet.copyWith(health: newHealth));
  }

  // Determinar o stage baseado em dias
  void _updateStage(int days) {
    PetStage newStage = PetStage.newborn;

    if (days >= 365) {
      newStage = PetStage.elderly;
    } else if (days >= 90) {
      newStage = PetStage.mature;
    } else if (days >= 30) {
      newStage = PetStage.adult;
    } else if (days >= 7) {
      newStage = PetStage.young;
    } else if (days >= 3) {
      newStage = PetStage.puppy;
    }

    if (newStage != _pet.stage) {
      _updatePet(_pet.copyWith(stage: newStage, happiness: 100));
      _onPetEvolved(newStage);
    }
  }

  void _updatePet(Pet newPet) {
    _pet = newPet.copyWith(lastUpdate: DateTime.now());
    _notifyListeners();
  }

  void _notifyListeners() {
    notifyListeners();
  }

  // Callback quando pet evolui
  void _onPetEvolved(PetStage newStage) {
    print('🐕 Pet evoluiu para: $newStage');
    // Aqui pode-se disparar notificações, animações, etc
  }

  // Reset pet (para testes)
  void resetPet() {
    _pet = Pet(
      name: 'Puff',
      stage: PetStage.newborn,
      daysWithoutNicotine: 0,
      moneySaved: 0.0,
      vcoins: 0,
      happiness: 80,
      health: 100,
      createdAt: DateTime.now(),
      lastUpdate: DateTime.now(),
    );
    notifyListeners();
  }
}
