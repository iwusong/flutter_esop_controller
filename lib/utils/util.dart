import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:esop/dto/Info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

const salt = "dficn397dzlaaqwnzx884466288";

showToastInDialog(BuildContext context, String msg) {
  showToast(
    msg,
    context: context,
    backgroundColor: Colors.white,
    textStyle: const TextStyle(color: Colors.black87),
    position: const StyledToastPosition(align: Alignment.topCenter,
      offset: 20
    ),
    animation: StyledToastAnimation.scale,
  );
}

showLoadingInDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

String computeSHA256(String input) {
  var bytes = utf8.encode(input); // 将字符串编码为 UTF-8
  var digest = sha256.convert(bytes); // 计算 SHA-256 哈希值
  return digest.toString(); // 返回哈希值的字符串表示
}

Future<bool> sendController(Info info, String cmd) async {
  final Completer<bool> completer = Completer();
  var SHA256 = computeSHA256(cmd + salt);
  String at = SHA256 + cmd;
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 12369)
      .then((RawDatagramSocket socket) {
    socket.broadcastEnabled = true;
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          String decode = utf8.decode(datagram.data);
          if (decode == SHA256) {
            socket.close();
            completer.complete(true); // 完成 completer 并返回结果
          }
        }
      }
    });
    send(at, info.source.split(":")[0],
        int.tryParse(info.source.split(":")[1]) as int, socket);
  });
  return completer.future; // 返回 Future
}

sendControllerWithLoadingInDialog(
    BuildContext context, Info info, String cmd) async {
  showLoadingInDialog(context);
  var ok = await sendController(info, cmd);
  if (ok && context.mounted) {
    Navigator.of(context).pop();
    showToastInDialog(context, " 设备接收成功 ");
  }
}



void sendPing(RawDatagramSocket socket) {
  send("ping", "172.16.60.255", 2369, socket);
}

void send(String msg, String add, int port, RawDatagramSocket socket) {
  socket.send(utf8.encode(msg), InternetAddress(add), port);
}
