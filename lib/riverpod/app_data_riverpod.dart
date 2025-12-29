import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appDataRiverpod =
    NotifierProvider<AppDataRiverpod, Set<String>>(AppDataRiverpod.new);

class AppDataRiverpod extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return {};
  }

  Future<void> loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = (prefs.getStringList('scan') ?? []).toSet(); // 使用一个默认值
  }

  // 保存ip列表
  Future<void> saveDataIpList(Set<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = value.toList();
    await prefs.setStringList('scan', list);
  }

  void add(String value) {
    final newSet = Set<String>.from(state)..add(value);

    state = newSet;
    saveDataIpList(newSet); // 保存更新后的列表
  }

  void removeOne(String ip) {
    var set = Set<String>.from(state)..remove(ip);
    state = set;
    saveDataIpList(set); // 保存更新后的列表
  }

  void clear() {
    state = {};
    saveDataIpList({}); // 保存更新后的列表
  }
}
