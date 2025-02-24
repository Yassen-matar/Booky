import 'dart:convert';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  static final SecureStorage _instance = SecureStorage._internal();

  static const String keybook = 'book';


  factory SecureStorage() {
    return _instance;
  }
  SecureStorage._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  // Detect first run after app install
  Future<bool> isFirstRun() async {
    String? firstRun = await readSecureData('first_run');
    if (firstRun == null) {
      await writeSecureData('first_run', 'true');
      return true;
    }
    return false;
  }

  // Clear storage on reinstall if necessary
  Future<void> clearOnReinstall() async {
    bool firstRun = await isFirstRun();
    if (firstRun) {
      await clearAll(); // Clear storage if first run after reinstall
    }
  }

/* 

  static Future<List<String>?> getListAppointmentReminder() async {
    String? jsonString = await storage.read(key: _keyListAppointmentReminder);

    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);

      List<String> myList = List<String>.from(
          decodedList); // Convert dynamic list to List<String>
      return myList;
    } else {
      return null;
    }
  }

  static Future<List<String>?> getListAppointmentReminderHours() async {
    String? jsonString =
        await storage.read(key: _keyListAppointmentReminderHours);

    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);

      List<String> myList = List<String>.from(
          decodedList); // Convert dynamic list to List<String>
      return myList;
    } else {
      return null;
    }
  }

  static Future getToken() async {
    return await storage.read(
      key: _keyToken,
    );
  }

  static Future getTimeZone() async {
    return await storage.read(
      key: _keytimeZone,
    );
  }

  static Future<bool?> getTheme() async {
    var value = await storage.read(key: _keyTheme);
    if (value == "true") {
      return true;
    } else if (value == "false") {
      return false;
    } else {
      return null;
    }
  }

  static Future<bool?> getCheckFirstLogOnBording() async {
    var value = await storage.read(key: _checkFirstLogOnBording);
    if (value == "true") {
      return true;
    } else if (value == "false") {
      return false;
    } else {
      return null;
    }
  }

  static Future<bool?> getGeolocator() async {
    var value = await storage.read(key: _keyPos);
    if (value == "true") {
      return true;
    } else if (value == "false") {
      return false;
    } else {
      return false;
    }
  }

  static Future<bool?> getIsLogin() async {
    var value = await storage.read(key: _keyIsLogin);
    if (value == "true") {
      return true;
    } else if (value == "false") {
      return false;
    } else {
      return false;
    }
  }

  static Future<bool?> getIsLocationPermissions() async {
    var value = await storage.read(key: _locationPermissions);
    if (value == "true") {
      return true;
    } else if (value == "false") {
      return false;
    } else {
      return false;
    }
  }

  static Future<MainSearchModel?> getSearchData() async {
    var value = await storage.read(key: _keySearchModel);

    if (value != "" && value != null) {
      var userData = jsonDecode(value);

      return MainSearchModel.fromJson(userData);
    } else {
      return null;
    }
  }

  static Future<LogInModel?> getUserLoginData() async {
    var value = await storage.read(key: _keyLogInModel);

    if (value != "" && value != null) {
      var userData = jsonDecode(value);

      return LogInModel.fromJson(userData);
    } else {
      return null;
    }
  }

  static Future<void> clearUserLoginData() async {
    await storage.delete(key: _keyLogInModel);
  }

  static Future<List<Result>?> getResultData() async {
    try {
      // Fetch the data stored under a specific key
      String? jsonString = await storage.read(key: _keyResultData);

      // If data is found, decode it and map to List<Result>
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Result> resultList =
            jsonData.map((json) => Result.fromJson(json)).toList();
        return resultList;
      } else {
        // If no data found, return null or an empty list
        return null;
      }
    } catch (e) {
      ("Error retrieving user data: $e");
      return null;
    }
  }

  static Future<List<Result>?> getStoreHistorySearch() async {
    try {
      // Fetch the data stored under a specific key
      String? jsonString = await storage.read(key: _keyStoreHistorySearch);

      // If data is found, decode it and map to List<Result>
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Result> resultList =
            jsonData.map((json) => Result.fromJson(json)).toList();
        return resultList;
      } else {
        // If no data found, return null or an empty list
        return null;
      }
    } catch (e) {
      ("Error retrieving user data: $e");
      return null;
    }
  }

  static Future setlang(String str) async {
    await storage.write(key: _keyLang, value: str);
  }

  static Future setToken(String str) async {
    await storage.write(key: _keyToken, value: str);
  }

  static Future setListAppointmentReminder(List<String>? str) async {
    print(str);
    await storage.write(
        key: _keyListAppointmentReminder, value: jsonEncode(str));
  }

  static Future setListAppointmentReminderHours(List<String>? str) async {
    print(str);
    await storage.write(
        key: _keyListAppointmentReminderHours, value: jsonEncode(str));
  }
  /*  static Future<void> setListAppointmentReminder(List<String>? result) async {
    try {
      if (result != null) {
        // Convert the list of Result objects to JSON string
        String jsonString = jsonEncode(result.map((r) => r.toJson()).toList());

        // Save the JSON string to secure storage under the 'userData' key
        await storage.write(
            key: _keyListAppointmentReminder, value: jsonString);
      } else {
        // If the result is null, clear the data in secure storage
        await storage.delete(key: _keyListAppointmentReminder);
      }
    } catch (e) {
      ("Error setting user data: $e");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  } */

  static Future setTimeZone(String str) async {
    await storage.write(key: _keytimeZone, value: str);
  }

  static Future<void> setTheme(bool isTheme) async {
    return storage.write(key: _keyTheme, value: isTheme ? "true" : "false");
  }

  static Future<void> setGeolocator(bool pos) async {
    return storage.write(key: _keyPos, value: pos ? "true" : "false");
  }

  static Future<void> setLogInModel(LogInModel user) async {
    return await storage.write(key: _keyLogInModel, value: jsonEncode(user));
  }

  static Future<void> setIsLogin(bool login) async {
    /* true log in  */
    return await storage.write(key: _keyIsLogin, value: jsonEncode(login));
  }

  static Future<void> setIsLocationPermissions(bool user) async {
    /* true log in  */
    return await storage.write(
        key: _locationPermissions, value: jsonEncode(user));
  }

  static Future<void> setIsCheckFirstLogOnBording(bool check) async {
    /* true log in  */
    return await storage.write(
        key: _checkFirstLogOnBording, value: jsonEncode(check));
  }

  static Future<void> setMainSearchModelData(MainSearchModel mainSearch) async {
    return await storage.write(
        key: _keySearchModel, value: jsonEncode(mainSearch));
  }

  static Future<void> setResultData(List<Result>? result) async {
    try {
      if (result != null) {
        // Convert the list of Result objects to JSON string
        String jsonString = jsonEncode(result.map((r) => r.toJson()).toList());

        // Save the JSON string to secure storage under the 'userData' key
        await storage.write(key: _keyResultData, value: jsonString);
      } else {
        // If the result is null, clear the data in secure storage
        await storage.delete(key: _keyResultData);
      }
    } catch (e) {
      ("Error setting user data: $e");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  }

  static Future<void> setStoreHistorySearch(List<Result>? result) async {
    try {
      if (result != null) {
        // Convert the list of Result objects to JSON string
        String jsonString = jsonEncode(result.map((r) => r.toJson()).toList());

        // Save the JSON string to secure storage under the 'userData' key
        await storage.write(key: _keyStoreHistorySearch, value: jsonString);
      } else {
        // If the result is null, clear the data in secure storage
        await storage.delete(key: _keyStoreHistorySearch);
      }
    } catch (e) {
      ("Error setting user data: $e");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  }

  static Future<void> setArticlesData(List<ArticlesModelResult>? result) async {
    try {
      if (result != null && result.isNotEmpty) {
        ("Here set  Data ");
        // Convert the list of Result objects to JSON string
        (result[0].titleEn);
        String jsonString = jsonEncode(result.map((r) => r.toJson()).toList());

        // Save the JSON string to secure storage under the 'userData' key
        await storage.write(key: _keyArticleData, value: jsonString);
      } else {
        // If the result is null, clear the data in secure storage
        await storage.delete(key: _keyArticleData);
      }
    } catch (e) {
      ("Error setting user data: $e");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  }

  static Future<void> setSponsorData(List<Result>? result) async {
    (result);
    try {
      if (result != null && result.isNotEmpty) {
        ("Here set  Data ");
        // Convert the list of Result objects to JSON string
        String jsonString = jsonEncode(result.map((r) => r.toJson()).toList());

        ("here is $jsonString");

        // Save the JSON string to secure storage under the 'userData' key
        await storage.write(key: _keySponserData, value: jsonString);
      } else {
        // If the result is null, clear the data in secure storage
        await storage.delete(key: _keySponserData);
      }
    } catch (e) {
      ("Error setting user data: $e");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  }

  static Future<List<Result>?> getSponsorData() async {
    try {
      // Fetch the data stored under a specific key
      String? jsonString = await storage.read(key: _keySponserData);

      // If data is found, decode it and map to List<Result>
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Result> resultList =
            jsonData.map((json) => Result.fromJson(json)).toList();
        return resultList;
      } else {
        // If no data found, return null or an empty list
        return null;
      }
    } catch (e) {
      ("Error retrieving user data: $e");
      return null;
    }
  }

  static Future<List<ArticlesModelResult>?> getArticlesData() async {
    try {
      // Fetch the data stored under a specific key
      String? jsonString = await storage.read(key: _keyArticleData);

      // If data is found, decode it and map to List<Result>
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<ArticlesModelResult> resultList =
            jsonData.map((json) => ArticlesModelResult.fromJson(json)).toList();
        return resultList;
      } else {
        // If no data found, return null or an empty list
        return null;
      }
    } catch (e) {
      ("Error retrieving user data: $e");
      return null;
    }
  }

  static Future<void> setSpecilityModelData(SpecialityModel result) async {
    return await storage.write(
        key: _keySpecilityModelData, value: jsonEncode(result));
  }

  static Future<SpecialityModel?> getSpecilityModelData() async {
    var value = await storage.read(key: _keySpecilityModelData);

    if (value != "" && value != null) {
      var specialityModel = jsonDecode(value);
      return SpecialityModel.fromJson(specialityModel);
    } else {
      return null;
      //  throw Exception('No speciality data found');  // Throw an error if no data is found
    }
  }

  static Future<void> setSpecilityData(List<Results> result) async {
    try {
      ("Here set  Data ");

      String jsonString = jsonEncode(result.map((r) => r.toJson()).toList());

      await storage.write(key: _keySpecilityData, value: jsonString);
    } catch (e) {
      ("Error setting user data: $e");
      rethrow;
    }
  }

  static Future<void> setProcedureData(ProceduresByCategory result) async {
    try {
      ("Here set  Data ");

      String jsonString = jsonEncode(result);

      await storage.write(key: _keyProcedureData, value: jsonString);
    } catch (e) {
      ("Error setting user data: $e");

      rethrow;
    }
  }

  static Future<ProceduresByCategory?> getProcedureData() async {
    try {
      // Fetch the data stored under a specific key
      var jsonString = await storage.read(key: _keyProcedureData);
      // If data is found, decode it and map to List<Result>
      if (jsonString != null) {
        ProceduresByCategory jsonData =
            ProceduresByCategory.fromJson(jsonDecode(jsonString));
        ProceduresByCategory resultList = jsonData;

        return resultList;
      } else {
        // If no data found, return null or an empty list
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Results>?> getSpecilityData() async {
    try {
      // Fetch the data stored under a specific key
      String? jsonString = await storage.read(key: _keySpecilityData);

      // If data is found, decode it and map to List<Result>
      if (jsonString != null) {
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Results> resultList =
            jsonData.map((json) => Results.fromJson(json)).toList();

        return resultList;
      } else {
        // If no data found, return null or an empty list
        return null;
      }
    } catch (e) {
      return null;
    }
  } */
}
