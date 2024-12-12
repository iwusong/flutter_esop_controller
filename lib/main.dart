import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:esop/dto/Info.dart';
import 'package:esop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller =
      TextEditingController(); // TextEditingController
  Set<Info> infos = {};
  late RawDatagramSocket socket;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    startUDPListener();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var infolist = infos.toList();
    var button = ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Wrap(
          spacing: 10.0, // 主轴方向间距
          runSpacing: 5, // 换行间距
          children: List.generate(
            infolist.length,
            (index) => Container(
              width: 100, // 控制容器宽度
              height: 50,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  clickDeviceDialog(context, infolist[index]);
                },
                child: SizedBox(
                  width: 100,
                  child: Text(infolist[index]
                      .uuid
                      .substring(infolist[index].uuid.length - 6)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    var search = TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: '搜索',
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w100,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none, // 去除边框
        ),
      ),
      onChanged: (text) {
        print(text);
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('App'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  infos.clear();
                });
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.6, // 设置最大宽度
                  ),
                  child: search,
                ),
                IconButton(
                  onPressed: () {
                    _controller.clear();
                    _focusNode.unfocus();
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            Expanded(child: button),
          ],
        ));
  }

  void startUDPListener() async {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 32367)
        .then((RawDatagramSocket socket) {
      this.socket = socket;
      socket.broadcastEnabled = true;
      socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = socket.receive();
          if (datagram != null) {
            var decode = utf8.decode(datagram.data);
            if (decode.startsWith("{")) {
              var info = Info.fromJson(json.decode(decode));
              var source = "${datagram.address.address}:${datagram.port}";
              info.source = source;
              setState(() {
                infos.add(info);
              });
            }
          }
        }
      });
      sendPing(socket);
      Timer.periodic(const Duration(seconds: 5), (timer) {
        sendPing(socket);
      });
    });
  }

  void clickDeviceDialog(BuildContext context, Info info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

        return Dialog(
          child: Container(
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.8,
                maxHeight: screenHeight * 0.8,
              ),
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const Align(
                    child: Text(
                      "设备信息",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("设备名称:${info.name}"),
                  Text("网页地址:${info.web}"),
                  Text("视频地址:${info.video}"),
                  Text("目标服务器:${info.ip}"),
                  Text("uuid:${info.uuid}"),
                  Text("设备:${info.device}"),
                  Text("来源:${info.source}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                      spacing: 10.0, // 主轴方向间距
                      runSpacing: 5, // 换行间距
                      children: [
                        buildButton("打开web", "web"),
                        buildButton("打开视频", "video"),
                        buildButton("显示配置", "code"),
                      ]),

                ],
              )),
        );
      },
    );
  }
}
