// 这个文件是 "main.dart"
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'device_item.dart';

part 'Info.freezed.dart';

part 'Info.g.dart';

@unfreezed
abstract class Info with _$Info {
  const Info._();

  factory Info({
    @Default("") String web,
    @Default("") String video,
    @Default("") String uuid,
    @Default("") String ip,
    @Default("") String name,
    @Default("") String source,
    @Default("") String device,
    @Default("") String SM2D,
    @Default([ ])
    @JsonKey(
        name: 'devicesInfo',

        ) // JsonKey在前
    List<DeviceItem> devicesList,
    @Default("") String code,
    @Default("") String type,
    @Default(0) int appversion,
  }) = _Info;

  factory Info.fromJson(Map<String, Object?> json) => _$InfoFromJson(json);

  @override
  int get hashCode => uuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Info && runtimeType == other.runtimeType && uuid == other.uuid;
}

