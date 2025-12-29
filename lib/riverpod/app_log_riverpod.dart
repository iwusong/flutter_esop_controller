import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appLogRiverpod =
    NotifierProvider<AppLogRiverpod, List<String>>(AppLogRiverpod.new);

class AppLogRiverpod extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void add(String value) {
    final newList = [...state, value];

    // 更新状态
    state = newList;
  }

  void clear() {
    state = [];
  }

  void addlogo(String value) {
    if (kDebugMode) {
      print(value);
    }
    final newList = [...state, value];

    if (newList.length > 100) {
      newList.removeAt(0);
    }
    state = [...newList];

  }
}
