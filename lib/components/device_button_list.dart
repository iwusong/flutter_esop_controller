import 'package:flutter/material.dart';

import '../dto/Info.dart';
import 'clickDeviceDialog.dart';
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
            key: ValueKey(infolist[index].uuid + infolist[index].type),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (infolist[index].type == "1") {
                    return Colors.deepOrange[100];
                  }
                  if (infolist[index].type == "2") {
                    return Colors.black12;
                  }
                  return null;
                },
              ),
            ),
            onPressed: () {
              clickDeviceDialog(context, infolist[index]);
            },
            child: deviceButtonText(st, isSwitched, infolist[index]),
          ),
        ),
      ),
    ],
  );
}

Widget deviceButtonText(String st, bool isSwitched, Info devInfo) {
  if (st == "") {
    if (isSwitched) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Text('${devInfo.name}  ',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
        Column(
          children: [
            Text(
              extractCodeFromUrl(devInfo.web),
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              devInfo.appversion,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ]);
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${devInfo.source.split(':')[0]} ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            devInfo.appversion,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ],
      );
    }
  } else {
    return Text(devInfo.uuid.substring(0, 13));
  }
}
