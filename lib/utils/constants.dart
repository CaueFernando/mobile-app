import 'package:flutter/material.dart';

// Cores
class AppColors {
  static const Color primary = Color(0xFF7C3AED); // Roxo
  static const Color secondary = Color(0xFF06B6D4); // Ciano
  static const Color success = Color(0xFF10B981); // Verde
  static const Color warning = Color(0xFFF59E0B); // Âmbar
  static const Color danger = Color(0xFFEF4444); // Vermelho
  static const Color info = Color(0xFF3B82F6); // Azul

  // Neutros
  static const Color bg = Color(0xFFFAFAFA);
  static const Color bgDark = Color(0xFF1F2937);
  static const Color text = Color(0xFF111827);
  static const Color textLight = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}

// Tamanhos
class AppSizes {
  static const double paddingXS = 4;
  static const double paddingSM = 8;
  static const double paddingMD = 16;
  static const double paddingLG = 24;
  static const double paddingXL = 32;

  static const double radiusSM = 4;
  static const double radiusMD = 8;
  static const double radiusLG = 12;
  static const double radiusXL = 16;

  static const double iconSM = 16;
  static const double iconMD = 24;
  static const double iconLG = 32;
  static const double iconXL = 48;
}

// Textos
class AppTexts {
  static const String appName = 'StepToStop';
  static const String appSlogan = 'Pare de fumar, comece a viver';

  // Dashboard
  static const String daysWithoutNicotine = 'Dias sem nicotina';
  static const String moneySaved = 'Dinheiro economizado';
  static const String vcoinsBalance = 'VCoins';

  // Botões
  static const String addPuff = '+1 Puff';
  static const String addCigarette = '+1 Cigarro';
  static const String hadCraving = 'Tive vontade';
  static const String emergency = 'Emergência';
  static const String share = 'Compartilhar';

  // Telas
  static const String dashboard = 'Dashboard';
  static const String statistics = 'Estatísticas';
  static const String shop = 'Shop';
  static const String history = 'Histórico';
  static const String profile = 'Perfil';
}

// Pet Stages
class PetStageDays {
  static const int newborn = 0;
  static const int puppy = 3;
  static const int young = 7;
  static const int adult = 30;
  static const int mature = 90;
  static const int elderly = 365;
}

// VCoins Reward
class VCoinsReward {
  static const int hourlyReward = 1;
  static const int dayReward = 5;
  static const int weekReward = 10;
  static const int monthReward = 50;
}
