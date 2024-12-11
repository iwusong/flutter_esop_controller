import 'dart:convert';
import 'dart:io';

import 'package:esop/dto/Info.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _controller =
      TextEditingController(); // TextEditingController
  Set<Info> infos = {};
  late RawDatagramSocket socket;

  @override
  void initState() {
    super.initState();
    startUDPListener();
  }

  @override
  Widget build(BuildContext context) {
    var infolist = infos.toList();
    var button = ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Wrap(
          spacing: 8.0, // 主轴方向间距
          runSpacing: 8.0, // 换行间距
          children: List.generate(
            infolist.length,
            (index) => Container(
              width: 100, // 控制容器宽度
              height: 50,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
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
    var text = TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: '搜索',
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w100, // 设置加粗
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
          // 输入框
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 150,
              child: text,
            ),
          ),
          IconButton(
            onPressed: () {
              _controller.clear();
              infos.clear();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: button), // 使用 Expanded 保证 ListView 不会超出屏幕
        ],
      ),
    );
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
              setState(() {
                infos.add(info);
              });
              print(infos.toString());
            }
          }
        }
      });
    });
  }

  void sendPing() {
    send("ping", "172.16.60.255", 2369, socket);
  }

  void send(String msg, String add, int port, RawDatagramSocket socket) {
    socket.send(utf8.encode(msg), InternetAddress(add), 2369);
  }
}
