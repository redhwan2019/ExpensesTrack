import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveData(List listTransaction) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('list_transactions', jsonEncode(listTransaction));
  }

  Future<List> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List list = jsonDecode(pref.getString('list_transactions'));
    return list;
  }
}
