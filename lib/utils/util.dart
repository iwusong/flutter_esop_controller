import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:esop/dto/Info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


const salt = "dficn397dzlaaqwnzx884466288";

showToastInDialog(BuildContext context, String msg,
    {Color color = Colors.black87}) {
  showToast(
    msg,
    context: context,
    backgroundColor: Colors.white,
    textStyle: TextStyle(color: color),
    position: const StyledToastPosition(align: Alignment.topCenter, offset: 20),
    animation: StyledToastAnimation.scale,
  );
}

void showLoadingInDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const PopScope(
        canPop: false, // 禁止返回键
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

String computeSHA256(String input) {
  var bytes = utf8.encode(input); // 将字符串编码为 UTF-8
  var digest = sha256.convert(bytes); // 计算 SHA-256 哈希值
  return digest.toString(); // 返回哈希值的字符串表示
}

Future<bool> sendController(Info info, String cmd, {int timeout = 3}) async {
  final Completer<bool> completer = Completer();
  var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
  socket.broadcastEnabled = true;
  var timer = Timer(Duration(seconds: timeout), () {
    socket.close();
    completer.complete(false);
  });
  socket.listen((RawSocketEvent event) {
    if (event == RawSocketEvent.read) {
      Datagram? datagram = socket.receive();
      if (datagram != null) {
        String decode = utf8.decode(datagram.data);
        if (decode == cmd) {
          timer.cancel();
          socket.close();
          completer.complete(true);
        }
      }
    }
  }).onError((e, a) {
    if (e is SocketException) {
      print(e);
      timer.cancel();
      socket.close();
      completer.complete(false);
    }
  });
  socket.send(utf8.encode(cmd), InternetAddress(info.source.split(":")[0]),
      int.tryParse(info.source.split(":")[1]) as int);
  return completer.future;
}

Future<bool> sendControllerWithLoadingInDialog(
    BuildContext context, Info info, String cmd) async {
  showLoadingInDialog(context);
  var ok = await sendController(info, cmd);
  if (context.mounted) {
    await sendController(info, "ping");
    if (context.mounted) {
      if (ok) {
        Navigator.of(context).pop();
        showToastInDialog(context, " 设备接收成功 ");
      } else {
        Navigator.of(context).pop();
        showToastInDialog(context, " 发送失败 ", color: Colors.deepOrange);
      }
    }
  }
  return ok;
}

int sendPing(RawDatagramSocket socket, String ip) {
  return send("ping", ip, 2369, socket);
}

void sendPingList(RawDatagramSocket socket, List<String> ip,
    ValueChanged<String> addlogo) async {
  var dateTime = DateTime.now().millisecondsSinceEpoch;
  for (var o in ip) {

    addlogo("scan  $o");
    for (int i = 1; i <= 255; i++) {
      var ip = "${o.split(".").sublist(0, 3).join(".")}.$i";
      sendPing(socket, ip);
    }
  }
  var i = DateTime.now().millisecondsSinceEpoch - dateTime;
  addlogo("扫描耗时 $i 毫秒");

}

int send(String msg, String add, int port, RawDatagramSocket socket) {
  return socket.send(utf8.encode(msg), InternetAddress(add), port);
}

String extractCodeFromUrl(String url) {
  Uri uri = Uri.parse(url);
  var queryParameter = uri.queryParameters['code'];
  if (queryParameter != null) {
    return queryParameter;
  } else {
    return "";
  }
}
