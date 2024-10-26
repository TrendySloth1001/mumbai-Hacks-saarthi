import 'package:get_storage/get_storage.dart';

class StorageUtility {
  static final StorageUtility _instance = StorageUtility._internal();

  factory StorageUtility() {
    return _instance;
  }

  StorageUtility._internal();

  static final box = GetStorage();

  // Add your methods or properties here

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await box.write(key, value); // Use box instead of _storage
  }

  //method to remove dATA
  Future<void> removeData(String key) async {
    await box.remove(key);
  }

  //method to read data
  Future<void> readData(String key) async {
    await box.read(key);
  }

  //clear all data in storage
  Future<void> clearAllData() async {
    await box.erase();
  }
}
