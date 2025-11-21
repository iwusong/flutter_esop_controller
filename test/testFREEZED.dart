import 'dart:convert';

import 'package:esop/dto/person.dart';

void main() {
  const  String a =   '{"web":"tttttttt","video":"ttttttttt","uuid":"9172e99d-858d-4064-8e80-8d4e2caa1d5a","ip":"192.168.0.9","name":"ttttt","last":"web","code":"未设置","type":"2","devicesInfo":"[{\\"productName\\":\\"SM-2D PRODUCT USB UART\\",\\"deviceId\\":3003,\\"vendorId\\":44176}]","appversion":80}';
  var decode = json.decode(a);
  var person = Person.fromJson(decode );
  print(person);

}
