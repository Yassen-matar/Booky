import 'package:booky/core/storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookLibraryLocalDataSource { 
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  
   Future saveBookLibrary(String str) async {
    await _secureStorage.write(key: SecureStorage.keybook, value: str);
  }
     Future fetchBookLibrary() async {
    return await _secureStorage.read(
      key: SecureStorage.keybook,
    );
  }

}