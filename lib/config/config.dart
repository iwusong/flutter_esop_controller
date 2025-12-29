import 'package:esop/riverpod/app_data_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utils/util.dart';

class ConfigSetting extends ConsumerWidget {
  const ConfigSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appData = ref.watch(appDataRiverpod);
    var appDatafunc = ref.read(appDataRiverpod.notifier);
    var list = appData.toList()..sort();
    var item = ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                "${list[index]} ",
                style: const TextStyle(fontSize: 22),
              )),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  appDatafunc.removeOne(list[index]);
                },
              ),
            ],
          ),
        );
      },
    );
    TextEditingController controller = TextEditingController();
    String input = "";

    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onDoubleTap: () {
              // 点击后触发的逻辑（如跳转页面）
              showLoadingInDialog(context);
              http
                  .get(Uri.parse('http://172.16.90.15/ip.txt'))
                  .then((response) {
                    response.body.split("\n").forEach((element) {
                      if (element.isNotEmpty) {

                        if (!appData.contains(element)) {
                          appDatafunc.add(element);
                        }
                      }
                    });
                    showToastInDialog(context, " 服务器获取ip ");
                  })
                  .catchError((error) {})
                  .whenComplete(() {
                    Navigator.of(context).pop();
                  });
            },
            child: const Text('设置'),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: '输入扫描地址',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          input = value;
                        },
                      )),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (input.isNotEmpty) {
                      if (!RegExp(
                        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
                      ).hasMatch(input)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text('错误'),
                              content: Text('输入不是ip地址'),
                            );
                          },
                        );
                        return;
                      }
                      if (appData.contains(
                          "${input.split(".").sublist(0, 3).join(".")}.*")) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text('错误'),
                              content: Text('该网段已加入扫描'),
                            );
                          },
                        );
                        return;
                      }
                      appDatafunc
                          .add("${input.split(".").sublist(0, 3).join(".")}.*");
                      input = "";
                      controller.clear();
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text('提示'),
                            content: Text(' 输入扫描地址后添加，同网段只需输入一次'),
                          );
                        },
                      );
                    }

                    // Add your delete action here
                  },
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            Expanded(
              child: item,
            ),
          ],
        ));
  }
}
