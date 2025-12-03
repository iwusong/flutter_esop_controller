import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_item.g.dart';


@JsonSerializable()
class DeviceItem {
  String productName;
  int deviceId;
  int vendorId;

 DeviceItem(  this.productName, this.deviceId, this.vendorId);

  factory DeviceItem.fromJson(Map<String, dynamic> json) => _$DeviceItemFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceItemToJson(this);

}
