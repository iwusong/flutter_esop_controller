import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:esop/dto/Info.dart';
import 'package:esop/utils/clickDeviceDialog.dart';
import 'package:esop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';
import 'config/config.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
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

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller =
      TextEditingController(); // TextEditingController
  Set<Info> infos = {};
  late RawDatagramSocket socket;
  String st = "";
  late Future<void> _loadDataFuture;
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = Provider.of<AppData>(context, listen: false)
        .loadDataFromSharedPreferences();
    startUDPListener();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return buildContent(context);
        }
      },
    );
  }

  Widget buildContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var infolist = st.isEmpty
        ? (infos.toList()..sort((a, b) => a.source.compareTo(b.source)))
        : infos.where((info) => info.uuid.contains(st)).toList()
      ..sort((a, b) => a.source.compareTo(b.source));

    var button = ListView(
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
                  ? Text(_isSwitched
                      ? infolist[index].name
                      : infolist[index].source)
                  : Text(infolist[index].uuid.substring(0, 13)),
            ),
          ),
        ),
      ],
    );
    var search = TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'uuid',
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
        setState(() {
          st = text;
        });
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('App'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("控制台输出"),
                      content: SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.9,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Consumer<AppData>(
                            builder: (context, appData, child) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_scrollController.hasClients) {
                                  _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent,
                                  );
                                }
                              });
                              return Column(
                                children: appData.logolist
                                    .map((e) => Text(e))
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.computer),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  infos.clear();
                });
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const NewRoute();
                  }),
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.5, // 设置最大宽度
                  ),
                  child: search,
                ),
                IconButton(
                  onPressed: () {
                    _controller.clear();
                    _focusNode.unfocus();
                    setState(() {
                      st = "";
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
                Container(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth * 0.3, // 设置最大宽度
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: _isSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ),
                        Text(_isSwitched ? "名称" : "ip地址"),
                      ],
                    )),
              ],
            ),
            Expanded(child: button),
          ],
        ));
  }

  void startUDPListener() async {
    var app = context.read<AppData>(); // 使用 context.read() 获取 app 的值

    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    socket.broadcastEnabled = true;
    var listen = socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          var decode = utf8.decode(datagram.data);
          print(decode);
          app.addlogo(decode);
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
    listen.onError((e, a) {
      if (e is SocketException) {
        print("listen.onError");
        print(e);
        print(a);
        app.addlogo(e.toString());
        app.addlogo(a.toString());
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      sendPingList(socket, app.ipList, app, port: socket.port);
      Timer.periodic(const Duration(seconds: 5), (timer) {
        sendPingList(socket, app.ipList, app, port: socket.port);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 释放控制器
    super.dispose();
  }
}
