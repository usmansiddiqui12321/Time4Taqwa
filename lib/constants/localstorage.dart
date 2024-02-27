import 'package:time4taqwa/exportall.dart';

class LocalStorage {
  static readjson({required String key}) {
    final storage = GetStorage();
    return storage.read(key);
  }

  static writejson({required String key, required dynamic value}) {
    final storage = GetStorage();
    return storage.write(key, value);
  }

  static deletejson({required String key}) {
    final storage = GetStorage();
    return storage.remove(key);
  }
}

class lsk {
  static const String token = "token";
  static const String appname = "Time 4 Taqwa";
  static const String fajarNamaz = "Fajar";
  static const String zuhrNamaz = "zuhrNamaz";
  static const String asarNamaz = "asarNamaz";
  static const String maghribNamaz = "maghribNamaz";
  static const String ishaNamaz = "ishaNamaz";
}
