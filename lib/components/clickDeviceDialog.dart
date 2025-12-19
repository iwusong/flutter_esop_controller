import 'package:esop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import '../dto/Info.dart';

void clickDeviceDialog(
    BuildContext context, Info info, ValueChanged<Info> func) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  TextButton buildEditButton(String title, String key, StateSetter setter) {
    return TextButton(
      onPressed: () async {
        var s = await prompt(
          context,
          initialValue: info[key],
          maxLines: 3,
          textOK: const Text('发送'),
          textCancel: const Text('取消'),
        );
        if (s != null && context.mounted) {
          var bool =
              await sendControllerWithLoadingInDialog(context, info, "$key!$s");
          if (bool) {
            var keyUpdateInfo = info.getKeyUpdateInfo(key, s);
            func(keyUpdateInfo);
            setter(() {
              info = keyUpdateInfo;
            });
          }
        }
      },
      child: Align(
        alignment: Alignment.centerLeft, // 左对齐
        child: Text(
          "$title:${info[key]}",
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  ElevatedButton buildButton(String buttonText, String cmd) {
    return ElevatedButton(
      onPressed: () async {
        sendControllerWithLoadingInDialog(context, info, cmd);
      },
      child: Text(buttonText),
    );
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.6,
                  maxHeight: screenHeight * 0.7,
                ),
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    const Align(
                      child: Text(
                        "设备信息",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildEditButton("设备名称", "name", setState),
                    buildEditButton("设备编码", "code", setState),
                    buildEditButton("网页地址", "web", setState),
                    buildEditButton("视频地址", "video", setState),
                    buildEditButton("目标服务器", "ip", setState),
                    buildEditButton("扫描枪接口", "SM2D", setState),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text("uuid:${info.uuid}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Row(
                        children: [
                          Text("来源ip:${info.source.split(':')[0]}"),
                          IconButton(
                              onPressed: () => {
                                    Clipboard.setData(ClipboardData(
                                        text: info.source.split(':')[0]))
                                  },
                              icon: const Icon(Icons.copy_all)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                          "外设信息:${info.devicesList.map((e) => e.productName).toString()}"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                        spacing: 10.0, // 主轴方向间距
                        runSpacing: 5, // 换行间距
                        children: [
                          buildButton("打开web", "web"),
                          buildButton("打开视频", "video"),
                          buildButton("显示uuid", "uuid"),
                          buildButton("清理进程", "cle!"),
                          buildButton("打开设置", "set!"),
                          buildButton("设置为看板", "type!1"),
                          buildButton("设置为工艺", "type!2"),
                          buildButton("检测外设", "usb!"),
                          buildButton("警报全关", "rgb!01 05 00 EF 00 00 FC 3F"),
                          buildButton("开红", "rgb!01 05 00 00 ff 00 8C 3A"),
                          buildButton("开黄", "rgb!01 05 00 01 ff 00 DD FA"),
                          buildButton("开绿", "rgb!01 05 00 02 ff 00 2D FA"),
                          buildButton("蜂鸣", "rgb!01 05 00 03 f0 00 79 CA"),
                          buildButton("红闪", "rgb!01 05 00 00 f0 00 89 CA"),
                          buildButton("重启", "restart!"),
                        ]),
                  ],
                )),
          );
        },
      );
    },
  );
}
