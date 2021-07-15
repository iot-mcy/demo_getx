import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US.dart';
import 'zh_CH.dart';

class TranslationService extends Translations {
  static Locale? get locale => Locale('zh', 'CH');
  static final fallbackLocale = Locale('zh', 'CH');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'zh_CH': zh_CH,
      };
}
