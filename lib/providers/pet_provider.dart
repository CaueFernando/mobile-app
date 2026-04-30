import 'package:flutter/foundation.dart';
import '../models/pet_model.dart';
import '../utils/constants.dart';

class PetProvider extends ChangeNotifier {
  Pet _pet = Pet(
    name: 'Puff',
    stage: PetStage.puppy,
    mood: PetMood.happy,
    daysWithoutNicotine: 3,
    moneySaved: 27.0,
    vcoins: 45,
    happiness: 92,
    health: 100,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    lastUpdate: DateTime.now(),
  );

  int _dailyPuffs = 0;
  int _dailyCigarettes = 0;
  int _cravingsToday = 0;
  int _relapseCount = 0;
  final List<String> _events = [];

  Pet get pet => _pet;
  int get dailyPuffs => _dailyPuffs;
  int get dailyCigarettes => _dailyCigarettes;
  int get cravingsToday => _cravingsToday;
  int get relapseCount => _relapseCount;
  List<String> get events => List.unmodifiable(_events);

  void logNicotineFreeDay() {
    final newDays = _pet.daysWithoutNicotine + 1;
    var bonus = VCoinsReward.nicotineFreeDay;

    if (newDays == 7) bonus += VCoinsReward.sevenDayStreak;
    if (newDays == 30) bonus += VCoinsReward.thirtyDayStreak;
    if (_isMilestone(newDays)) bonus += VCoinsReward.milestone;

    _pet = _pet.copyWith(
      daysWithoutNicotine: newDays,
      stage: _stageForDays(newDays),
      mood: _moodForCleanDay(newDays),
      vcoins: (_pet.vcoins + bonus).clamp(0, 999999),
      happiness: (_pet.happiness + 6).clamp(0, 100),
      moneySaved: _pet.moneySaved + 9,
      lastUpdate: DateTime.now(),
    );
    _events.insert(0, '+$bonus VCoins: nicotine-free day $newDays');
    notifyListeners();
  }

  void logPuff() {
    _dailyPuffs += 1;
    _relapseCount += 1;
    _pet = _pet.copyWith(
      mood: PetMood.sad,
      vcoins: (_pet.vcoins + VCoinsReward.relapsePenalty).clamp(0, 999999),
      happiness: (_pet.happiness - 12).clamp(0, 100),
      health: (_pet.health - 3).clamp(0, 100),
      lastUpdate: DateTime.now(),
    );
    _events.insert(0, 'Relapse logged: puff');
    notifyListeners();
  }

  void logCigarette() {
    _dailyCigarettes += 1;
    _relapseCount += 1;
    _pet = _pet.copyWith(
      mood: PetMood.sad,
      vcoins: (_pet.vcoins + VCoinsReward.relapsePenalty).clamp(0, 999999),
      happiness: (_pet.happiness - 18).clamp(0, 100),
      health: (_pet.health - 6).clamp(0, 100),
      lastUpdate: DateTime.now(),
    );
    _events.insert(0, 'Relapse logged: cigarette');
    notifyListeners();
  }

  void logCraving({required int intensity, required String reason}) {
    _cravingsToday += 1;
    _pet = _pet.copyWith(
      mood: intensity >= 4 ? PetMood.proud : PetMood.happy,
      vcoins: (_pet.vcoins + VCoinsReward.cravingLog).clamp(0, 999999),
      happiness: (_pet.happiness + 3).clamp(0, 100),
      lastUpdate: DateTime.now(),
    );
    _events.insert(0, '+2 VCoins: craving logged ($reason, $intensity/5)');
    notifyListeners();
  }

  void putPetToSleep() {
    _pet = _pet.copyWith(mood: PetMood.sleeping, lastUpdate: DateTime.now());
    notifyListeners();
  }

  void wakePetHappy() {
    _pet = _pet.copyWith(mood: PetMood.happy, lastUpdate: DateTime.now());
    notifyListeners();
  }

  void setPetName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    _pet = _pet.copyWith(name: trimmed, lastUpdate: DateTime.now());
    notifyListeners();
  }

  void buyShopItem(int price, String itemName) {
    if (_pet.vcoins < price) return;
    _pet = _pet.copyWith(
      vcoins: _pet.vcoins - price,
      mood: PetMood.excited,
      happiness: (_pet.happiness + 5).clamp(0, 100),
      lastUpdate: DateTime.now(),
    );
    _events.insert(0, 'Bought $itemName for $price VCoins');
    notifyListeners();
  }

  void resetPet() {
    _pet = Pet(
      name: 'Puff',
      stage: PetStage.newborn,
      mood: PetMood.happy,
      daysWithoutNicotine: 0,
      moneySaved: 0.0,
      vcoins: 0,
      happiness: 80,
      health: 100,
      createdAt: DateTime.now(),
      lastUpdate: DateTime.now(),
    );
    _dailyPuffs = 0;
    _dailyCigarettes = 0;
    _cravingsToday = 0;
    _relapseCount = 0;
    _events.clear();
    notifyListeners();
  }

  bool _isMilestone(int days) =>
      days == 7 || days == 30 || days == 90 || days == 365;

  PetMood _moodForCleanDay(int days) {
    if (days == 7 || days == 30 || days == 90 || days == 365) {
      return PetMood.proud;
    }
    return days % 3 == 0 ? PetMood.excited : PetMood.happy;
  }

  PetStage _stageForDays(int days) {
    if (days >= PetStageDays.elder) return PetStage.elder;
    if (days >= PetStageDays.mature) return PetStage.mature;
    if (days >= PetStageDays.adult) return PetStage.adult;
    if (days >= PetStageDays.young) return PetStage.young;
    if (days >= PetStageDays.puppy) return PetStage.puppy;
    return PetStage.newborn;
  }
}
