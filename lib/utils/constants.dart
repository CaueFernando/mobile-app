import 'package:flutter/material.dart';

enum AppLanguage { pt, en }

class AppColors {
  static const Color primary = Color(0xFF159C20);
  static const Color primaryDark = Color(0xFF0D6F19);
  static const Color secondary = Color(0xFF176FD6);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFFFC233);
  static const Color danger = Color(0xFFE64235);
  static const Color info = Color(0xFF7C3AED);
  static const Color cream = Color(0xFFFFFCF5);
  static const Color panel = Color(0xFFFFFFFF);
  static const Color panelDark = Color(0xFF111827);
  static const Color bg = Color(0xFFF7F5EF);
  static const Color bgDark = Color(0xFF07111F);
  static const Color text = Color(0xFF111827);
  static const Color textLight = Color(0xFF5F6673);
  static const Color border = Color(0xFFE7E2D8);
  static const Color borderDark = Color(0xFF263142);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF070B12);
  static const Color gold = Color(0xFFFFB800);
}

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
}

class AppTexts {
  static const String appName = 'SteptoStop';
  static String get dashboard => t('dashboard');
  static String get statistics => t('statistics');
  static String get shop => t('shop');
  static String get history => t('history');
  static String get profile => t('profile');
  static String get daysWithoutNicotine => t('daysClean');
  static String get moneySaved => t('moneySaved');
  static String get vcoinsBalance => t('vcoins');
  static String get addPuff => t('addPuff');
  static String get addCigarette => t('addCigarette');
  static String get hadCraving => t('hadCraving');
  static String get emergency => t('emergency');
  static String get share => t('share');

  static const Map<String, Map<AppLanguage, String>> values = {
    'slogan': {
      AppLanguage.pt: 'Um passo de cada vez.',
      AppLanguage.en: 'One step at a time.',
    },
    'dashboard': {
      AppLanguage.pt: 'Dashboard',
      AppLanguage.en: 'Dashboard',
    },
    'statistics': {
      AppLanguage.pt: 'Estat\u00edsticas',
      AppLanguage.en: 'Statistics',
    },
    'shop': {
      AppLanguage.pt: 'Pet Shop',
      AppLanguage.en: 'Pet Shop',
    },
    'history': {
      AppLanguage.pt: 'Hist\u00f3rico',
      AppLanguage.en: 'History',
    },
    'profile': {
      AppLanguage.pt: 'Perfil',
      AppLanguage.en: 'Profile',
    },
    'daysClean': {
      AppLanguage.pt: 'Dias sem nicotina',
      AppLanguage.en: 'Nicotine-free days',
    },
    'keepGoing': {
      AppLanguage.pt: 'Parab\u00e9ns! Continue assim!',
      AppLanguage.en: 'Great job! Keep going!',
    },
    'moneySaved': {
      AppLanguage.pt: 'Dinheiro economizado',
      AppLanguage.en: 'Money saved',
    },
    'vcoins': {
      AppLanguage.pt: 'VCoins',
      AppLanguage.en: 'VCoins',
    },
    'addPuff': {
      AppLanguage.pt: '+1 Puff',
      AppLanguage.en: '+1 Puff',
    },
    'addCigarette': {
      AppLanguage.pt: '+1 Cigarro',
      AppLanguage.en: '+1 Cigarette',
    },
    'hadCraving': {
      AppLanguage.pt: 'Tive vontade',
      AppLanguage.en: 'I had a craving',
    },
    'emergency': {
      AppLanguage.pt: 'Emerg\u00eancia',
      AppLanguage.en: 'Emergency',
    },
    'share': {
      AppLanguage.pt: 'Compartilhar progresso',
      AppLanguage.en: 'Share progress',
    },
  };

  static String t(String key, [AppLanguage language = AppLanguage.pt]) {
    return values[key]?[language] ?? values[key]?[AppLanguage.en] ?? key;
  }
}

class PetStageDays {
  static const int newborn = 0;
  static const int puppy = 3;
  static const int young = 7;
  static const int adult = 30;
  static const int mature = 90;
  static const int elder = 365;
}

class VCoinsReward {
  static const int nicotineFreeDay = 10;
  static const int cravingLog = 2;
  static const int sevenDayStreak = 30;
  static const int milestone = 50;
  static const int thirtyDayStreak = 100;
  static const int relapsePenalty = -15;
}
