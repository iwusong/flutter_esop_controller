import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:esop/utils/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';
import 'components/device_button_list.dart';
import 'components/search_text_field.dart';
import 'config/config.dart';
import 'dto/Info.dart';
import 'main.dart';

class HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller =
  TextEditingController(); // TextEditingController
  Set<Info> infos = {};
  late RawDatagramSocket socket;
  String st = "";
  late Future<void> _loadDataFuture;
  bool _isSwitched = true;

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

    List<Info> infolist;

    if (st.isNotEmpty) {
      infolist = infos.where((info) => info.uuid.contains(st)).toList()
        ..sort((a, b) => a.uuid.compareTo(b.uuid));
    } else if (_isSwitched) {
      infolist = infos.toList()..sort((a, b) => a.name.compareTo(b.name));
    } else {
      infolist = infos.toList()..sort((a, b) => a.source.compareTo(b.source));
    }
    void setSearchText(String value) {
      setState(() {
        st = value;
      });
    }

    var button = buildButtonListView(infolist, context, st, _isSwitched);
    var search = buildSearchTextField(_controller, _focusNode, setSearchText);

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
              icon: const Icon(Icons.select_all),
              onPressed: () {},
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
                        Text(_isSwitched ? "设备名" : "ip地址"),
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
          if (kDebugMode) {
            print(decode);
          }
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
        app.addlogo("listen.onError");
        app.addlogo(e.toString());
        app.addlogo(a.toString());
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      sendPingList(
        socket,
        app.ipList.toList(),
        app,
      );
      Timer.periodic(const Duration(seconds: 5), (timer) {
        sendPingList(
          socket,
          app.ipList.toList(),
          app,
        );
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 释放控制器
    super.dispose();
  }
}
