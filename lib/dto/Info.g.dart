// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Info _$InfoFromJson(Map<String, dynamic> json) => _Info(
      web: json['web'] as String? ?? "",
      video: json['video'] as String? ?? "",
      uuid: json['uuid'] as String? ?? "",
      ip: json['ip'] as String? ?? "",
      name: json['name'] as String? ?? "",
      source: json['source'] as String? ?? "",
      device: json['device'] as String? ?? "",
      SM2D: json['SM2D'] as String? ?? "",
      devicesList: (json['devicesInfo'] as List<dynamic>?)
              ?.map((e) => DeviceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      code: json['code'] as String? ?? "",
      type: json['type'] as String? ?? "",
      appversion: (json['appversion'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$InfoToJson(_Info instance) => <String, dynamic>{
      'web': instance.web,
      'video': instance.video,
      'uuid': instance.uuid,
      'ip': instance.ip,
      'name': instance.name,
      'source': instance.source,
      'device': instance.device,
      'SM2D': instance.SM2D,
      'devicesInfo': instance.devicesList,
      'code': instance.code,
      'type': instance.type,
      'appversion': instance.appversion,
    };
