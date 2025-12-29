import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:esop/riverpod/app_data_riverpod.dart';
import 'package:esop/riverpod/app_log_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/Info.dart';
import 'util.dart';

void startUDPListener(WidgetRef ref, void Function(Info info) addinfo) async {
  var addlogo = ref.read(appLogRiverpod.notifier).addlogo;
  RawDatagramSocket socket =
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
  socket.broadcastEnabled = true;
  var listen = socket.listen((RawSocketEvent event) {
    if (event == RawSocketEvent.read) {
      Datagram? datagram = socket.receive();
      if (datagram != null) {
        var decode = utf8.decode(datagram.data);

        addlogo(decode);
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
      addlogo("listen.onError");
      addlogo(e.toString());
      addlogo(a.toString());
    }
  });
  List<String> list()=> ref.read(appDataRiverpod).toList();
  Future.delayed(const Duration(seconds: 1), () {
    sendPingList(socket, list(), addlogo);
    Timer.periodic(const Duration(seconds: 5), (timer) {
      sendPingList(socket, list(), addlogo);
    });
  });
}
