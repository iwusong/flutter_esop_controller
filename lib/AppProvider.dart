import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dto/Info.dart';

class AppData with ChangeNotifier {
  Set<Info> infos = {};

  void addInfo(Info info) {
    infos.add(info);
    notifyListeners();
  }

  void clearInfo() {
    infos.clear();
    notifyListeners();
  }

  bool scanIng = false;

  bool get isScanning => scanIng;

  void changeScanIng(bool value) {
    scanIng = value;
    notifyListeners();
  }

  Set<String> _ipList = {};

  Set<String> get ipList => _ipList;

  Future<void> loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ipList = (prefs.getStringList('scan') ?? []).toSet(); // 使用一个默认值
    notifyListeners(); // 通知监听者更新
  }

  Future<void> saveDataIpList(Set<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = value.toList();
    list.sort();
    await prefs.setStringList('scan', list);
    _ipList = value.toSet();
    notifyListeners(); // 通知监听者更新
  }

  void add(String value) {
    _ipList.add(value);
    saveDataIpList(_ipList); // 保存更新后的列表
  }

  void removeOne(String ip) {
    _ipList.remove(ip);
    saveDataIpList(_ipList); // 保存更新后的列表
  }

  void clear() {
    _ipList.clear();
    saveDataIpList(_ipList); // 保存更新后的列表
  }

  List<String> logolist = [];

  void addlogo(String value) {
    if (kDebugMode) {
      print(value);
    }
    logolist.add(value);
    if (logolist.length > 100) {
      logolist.removeAt(0);
    }
    notifyListeners(); // 通知监听者更新
  }
}
