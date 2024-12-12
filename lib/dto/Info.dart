class Info {
  final String web;
  final String video;
  final String uuid;
  final String ip;
  final String name;
  String source;
  final String device;

  Info(this.web, this.video, this.uuid, this.ip, this.name, this.source,
      this.device);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Info && runtimeType == other.runtimeType && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Info{web: $web, video: $video, uuid: $uuid, ip: $ip, name: $name, source: $source, device: $device}';
  }

  Info.fromJson(Map<String, dynamic> json)
      : web = json['web'] ?? "",
        video = json['video'] ?? "",
        uuid = json['uuid'] ?? "",
        ip = json['ip'] ?? "",
        source = json['source'] ?? "",
        name = json['name'] ?? "",
        device = json['device'] ?? "";
}
