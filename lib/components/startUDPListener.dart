import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../AppProvider.dart';
import '../dto/Info.dart';
import '../utils/util.dart';

void startUDPListener(BuildContext context,
    void Function(Info info) addinfo,) async {
  var app = context.read<AppData>(); // 使用 context.read() 获取 app 的值

  RawDatagramSocket socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4, 0);
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
          addinfo(info);
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
    Timer.periodic(const Duration(seconds: 1), (timer) {
      sendPingList(
        socket,
        app.ipList.toList(),
        app,
      );
    });
  });
}
