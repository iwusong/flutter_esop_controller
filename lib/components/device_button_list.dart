import 'package:flutter/material.dart';

import '../dto/Info.dart';
import '../utils/clickDeviceDialog.dart';
import '../utils/util.dart';

ListView buildButtonListView(
    List<Info> infolist, BuildContext context, String st, bool isSwitched) {
  return ListView(
    padding: const EdgeInsets.all(16.0),
    children: [
      Wrap(
        spacing: 10.0, // 主轴方向间距
        runSpacing: 5, // 换行间距
        children: List.generate(
          infolist.length,
          (index) => ElevatedButton(
            onPressed: () {
              clickDeviceDialog(context, infolist[index]);
            },
            child: st == ""
                ? Text(isSwitched
                    ? infolist[index].name +
                        extractCodeFromUrl(infolist[index].web)
                    : infolist[index].source)
                : Text(infolist[index].uuid.substring(0, 13)),
          ),
        ),
      ),
    ],
  );
}

