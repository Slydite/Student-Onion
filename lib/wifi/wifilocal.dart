import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _instance;
  static SharedPreferences get instance => _instance!;

  static Future<SharedPreferences> init() async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance!;
  }
}

class Items {
  final String user;
  final String pass;

  Items({required this.user, required this.pass});

  Items.fromMap(Map map)
      : user = map['user'] as String,
        pass = map['pass'] as String;
  Map toMap() {
    return {'user': user, 'pass': pass};
  }
}

class Credentials with ChangeNotifier {
  List<Items> credentials = [];

  SharedPreferences? sharedPreferences2;

  UnmodifiableListView<Items> get allcategories =>
      UnmodifiableListView(credentials);

  void addCred(Items item) {
    credentials.add(item);
    saveCredsToLocalStorage();
    notifyListeners();
  }

  void deleteCred(Items item) {
    credentials.remove(item);
    updateCredsToLocalStorage();
    notifyListeners();
  }

  void initSharedPreferences() async {
    await SharedPreferencesHelper.init();
    sharedPreferences2 = SharedPreferencesHelper.instance;
    loadCredsFromLocalStorage();
    notifyListeners();
  }

  void saveCredsToLocalStorage() {
    List<String>? spList2 =
        credentials.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences2!.setStringList('wificredentials', spList2);
  }

  void loadCredsFromLocalStorage() {
    List<String>? spList2 =
        sharedPreferences2!.getStringList('wificredentials');
    if (spList2 != null) {
      credentials =
          spList2.map((item) => Items.fromMap(json.decode(item))).toList();
    }
  }

  void updateCredsToLocalStorage() {
    sharedPreferences2!.remove('wificredentials');
    saveCredsToLocalStorage();
  }
}
