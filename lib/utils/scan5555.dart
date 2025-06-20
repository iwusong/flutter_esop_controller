import 'dart:io';

void isPortOpen(String ip, int port) {
  var connect = Socket.connect(ip, port, timeout: const Duration(seconds: 5));
  connect.then((socket) {
    print('$ip:$port 端口开放');
  }).catchError((e) {
    // print("$ip:$port 端口关闭或不可达");
  });
}

void main() async {
  String ip = '192.168.8.1';
  int port = 5555;
  isPortOpen(ip, port);
  for (int i = 1; i <= 255; i++) {
    String currentIp = '192.168.8.$i';
    isPortOpen(currentIp, port);
  }
  print('object');

}
