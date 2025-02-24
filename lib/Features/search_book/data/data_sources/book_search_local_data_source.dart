import 'package:booky/core/storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookSearchLocalDataSource { 
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  
   Future saveBookSearch(String str) async {
    await _secureStorage.write(key: SecureStorage.keybook, value: str);
  }
     Future fetchBookSearch() async {
    return await _secureStorage.read(
      key: SecureStorage.keybook,
    );
  }

}