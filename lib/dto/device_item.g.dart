// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceItem _$DeviceItemFromJson(Map<String, dynamic> json) => DeviceItem(
      json['productName'] as String,
      (json['deviceId'] as num).toInt(),
      (json['vendorId'] as num).toInt(),
    );

Map<String, dynamic> _$DeviceItemToJson(DeviceItem instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'deviceId': instance.deviceId,
      'vendorId': instance.vendorId,
    };
