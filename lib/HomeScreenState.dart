import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';
import 'components/consoleDialog.dart';
import 'components/device_button_list.dart';
import 'components/search_text_field.dart';
import 'components/startUDPListener.dart';
import 'config/config.dart';
import 'dto/Info.dart';
import 'main.dart';

class HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller =
      TextEditingController(); // TextEditingController
  Set<Info> infos = {};

  String st = "";
  late Future<void> _loadDataFuture;
  bool _isSwitched = true;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = Provider.of<AppData>(context, listen: false)
        .loadDataFromSharedPreferences();
    startUDPListener(context, (Info newInfo) {
      setState(() {
        // todo 性能待优化
        infos.removeWhere((info) => info.uuid == newInfo.uuid);
        infos.add(newInfo);
      });
    });
  }

  void setSearchText(String value) {
    setState(() {
      st = value;
    });
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

    List<Info> infolist;

    if (st.isNotEmpty) {
      infolist = infos.where((info) => info.uuid.contains(st)).toList()
        ..sort((a, b) => a.uuid.compareTo(b.uuid));
    } else if (_isSwitched) {
      infolist = infos.toList()..sort((a, b) => a.name.compareTo(b.name));
    } else {
      infolist = infos.toList()..sort((a, b) => a.source.compareTo(b.source));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('App'),
          actions: [
            IconButton(
              onPressed: () {
                showLogDialog(context);
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
              onPressed: () {
                //    todo 多选操作
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ConfigSetting();
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
                    maxWidth: screenWidth * 0.4, // 设置最大宽度
                  ),
                  child: buildSearchTextField(
                      _controller, _focusNode, setSearchText),
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
                      maxWidth: screenWidth * 0.4, // 设置最大宽度
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
                            activeThumbColor: Colors.green,
                          ),
                        ),
                        Text(_isSwitched ? "设备名" : "ip地址"),
                      ],
                    )),
              ],
            ),
            Expanded(
                child: buildButtonListView(infolist, context, st, _isSwitched)),
          ],
        ));
  }

  @override
  void dispose() {
    // _scrollController.dispose(); // 释放控制器
    super.dispose();
  }
}
