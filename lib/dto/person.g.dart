// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Person _$PersonFromJson(Map<String, dynamic> json) => _Person(
      web: json['web'] as String? ?? "",
      video: json['video'] as String? ?? "",
      uuid: json['uuid'] as String? ?? "",
      ip: json['ip'] as String? ?? "",
      name: json['name'] as String? ?? "",
      source: json['source'] as String? ?? "",
      device: json['device'] as String? ?? "",
      code: json['code'] as String? ?? "",
      type: json['type'] as String? ?? "",
      appversion: json['appversion'],
    );

Map<String, dynamic> _$PersonToJson(_Person instance) => <String, dynamic>{
      'web': instance.web,
      'video': instance.video,
      'uuid': instance.uuid,
      'ip': instance.ip,
      'name': instance.name,
      'source': instance.source,
      'device': instance.device,
      'code': instance.code,
      'type': instance.type,
      'appversion': instance.appversion,
    };
