import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class CommonPreferences {
  Future<String> getJwt() async {
    String? jwt = await _storage.read(key: 'jwt');
    if (jwt == null) {
      return '';
    }
    return jwt;
  }

  void setJwt(String jwt) async {
    await _storage.write(key: 'jwt', value: jwt);
  }

  void deleteJwt() async {
    await _storage.delete(key: 'jwt');
  }
}
