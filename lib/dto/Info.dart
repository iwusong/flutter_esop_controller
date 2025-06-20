class Info {
  String web;
  String video;
  String uuid;
  String ip;
  String name;
  String source;
  String device;
  String code;
  String appversion;

  Info(this.web, this.video, this.uuid, this.ip, this.name, this.source,
      this.device, this.code, this.appversion);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Info && runtimeType == other.runtimeType && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Info(web: $web, video: $video, uuid: $uuid, ip: $ip, name: $name, source: $source, device: $device, code: $code)';
  }

  Info.fromJson(Map<String, dynamic> json)
      : web = json['web'] ?? "",
        video = json['video'] ?? "",
        uuid = json['uuid'] ?? "",
        ip = json['ip'] ?? "",
        source = json['source'] ?? "",
        name = json['name'] ?? "",
        code = json['code'] ?? "",
        appversion = json['appversion'] != null
            ? 'v${json['appversion']}'
            : "旧版本",
        device = json['device'] ?? "";

  dynamic operator [](String key) {
    switch (key) {
      case 'web':
        return web;
      case 'video':
        return video;
      case 'uuid':
        return uuid;
      case 'ip':
        return ip;
      case 'name':
        return name;
      case 'source':
        return source;
      case 'device':
        return device;
      case 'code':
        return code;
      case 'appversion':
        return appversion;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }

  // 通过 []= 设置属性值
  void operator []=(String key, dynamic value) {
    switch (key) {
      case 'web':
        web = value;
        break;
      case 'video':
        video = value;
        break;
      case 'uuid':
        uuid = value;
        break;
      case 'ip':
        ip = value;
        break;
      case 'name':
        name = value;
        break;
      case 'source':
        source = value;
        break;
      case 'device':
        device = value;
        break;
      case 'code':
        code = value;
        break;
      case 'appversion':
        appversion = appversion;
        break;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}
