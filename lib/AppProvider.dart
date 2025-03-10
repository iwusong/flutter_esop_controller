import 'package:flutter/cupertino.dart';
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

  List<String> _ipList = [];

  List<String> get ipList => _ipList;

  Future<void> loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ipList = prefs.getStringList('scan') ?? []; // 使用一个默认值
    notifyListeners(); // 通知监听者更新
  }

  Future<void> saveDataIpList(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value.sort();
    await prefs.setStringList('scan', value);
    _ipList = value;
    notifyListeners(); // 通知监听者更新
  }

  void add(String value) {
    _ipList.add(value);
    saveDataIpList(_ipList); // 保存更新后的列表
  }

  void removeAt(int index) {
    _ipList.removeAt(index);
    saveDataIpList(_ipList); // 保存更新后的列表
  }

  void clear() {
    _ipList.clear();
    saveDataIpList(_ipList); // 保存更新后的列表
  }

  List<String> logolist = [];
  void addlogo(String value) {
    logolist.add(value);
    if (logolist.length > 100) {
      logolist.removeAt(0);
    }
    notifyListeners(); // 通知监听者更新
  }
}
