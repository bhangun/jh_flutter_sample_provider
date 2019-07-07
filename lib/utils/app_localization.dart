import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'foo': 'Foo',
      'bar': 'Bar'
    },
    'ar': {
      'foo': 'فو',
      'bar': 'بار'
    }
  };

  String translate(key) {
    return _localizedValues[locale.languageCode][key];
  }

  static String of(BuildContext context, String key) {
    return Localizations.of<AppLocalizations>(context, 
      AppLocalizations).translate(key);
  }
}

class AppLocalizationsDelegate extends 
  LocalizationsDelegate<AppLocalizations> {
  
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => 
    ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>
      (AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
