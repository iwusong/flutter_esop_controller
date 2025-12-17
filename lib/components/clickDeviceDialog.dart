import 'package:esop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import '../dto/Info.dart';

typedef InfoUpdater = Info Function(Info info, dynamic value);

final Map<String, InfoUpdater> _infoUpdaters = {
  'name': (Info info, dynamic value) => info.copyWith(name: value),
  'code': (Info info, dynamic value) => info.copyWith(code: value),
  'web': (Info info, dynamic value) => info.copyWith(web: value),
  'video': (Info info, dynamic value) => info.copyWith(video: value),
  'ip': (Info info, dynamic value) => info.copyWith(ip: value),
  'SM2D': (Info info, dynamic value) => info.copyWith(SM2D: value),
};

void clickDeviceDialog(BuildContext context, Info info) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var clickInfo = info;
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      ElevatedButton buildButton(String buttonText, String cmd) {
        return ElevatedButton(
          onPressed: () async {
            sendControllerWithLoadingInDialog(context, info, cmd);
          },
          child: Text(buttonText),
        );
      }

      buildEditButton(
          String title, StateSetter setState, String key, String oldvalue) {
        return TextButton(
          onPressed: () async {
            var s = await prompt(
              context,
              initialValue: oldvalue,
              maxLines: 3,
              textOK: const Text('发送'),
              textCancel: const Text('取消'),
            );
            if (s != null && context.mounted) {
              var bool = await sendControllerWithLoadingInDialog(
                  context, info, "$key!$s");
              if (bool) {
                final setter = _infoUpdaters[key];
                setState(() {
                  info = setter!(clickInfo, s);

                });
              }
            }
          },
          child: Align(
            alignment: Alignment.centerLeft, // 左对齐
            child: Text(
              "$title:$oldvalue",
              textAlign: TextAlign.start,
            ),
          ),
        );
      }

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
                    buildEditButton("设备名称", setState, "name", clickInfo.name),
                    buildEditButton("设备编码", setState, "code", clickInfo.code),
                    buildEditButton("网页地址", setState, "web", clickInfo.web),
                    buildEditButton("视频地址", setState, "video", clickInfo.video),
                    buildEditButton("目标服务器", setState, "ip", clickInfo.ip),
                    buildEditButton("扫描枪接口", setState, "SM2D", clickInfo.SM2D),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text("uuid:${clickInfo.uuid}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Row(
                        children: [
                          Text("来源ip:${clickInfo.source.split(':')[0]}"),
                          IconButton(
                              onPressed: () => {
                                    Clipboard.setData(ClipboardData(
                                        text: clickInfo.source.split(':')[0]))
                                  },
                              icon: const Icon(Icons.copy_all)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                          "外设信息:${clickInfo.devicesList.map((e) => e.productName).toString()}"),
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
