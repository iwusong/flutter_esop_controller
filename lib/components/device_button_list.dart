import 'package:flutter/material.dart';

import '../dto/Info.dart';
import 'clickDeviceDialog.dart';
import '../utils/util.dart';

Widget deviceButtonText(String st, bool isSwitched, Info devInfo) {
  String appversion =
      devInfo.appversion == 0 ? "旧版本" : devInfo.appversion.toString();

  if (st == "") {
    if (isSwitched) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Text('${devInfo.name} ',
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
            Row(
              children: [
                Text(
                  appversion,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  devInfo.devicesList.isEmpty?" ":"外设:${devInfo.devicesList.length}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            )

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
            appversion,
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
