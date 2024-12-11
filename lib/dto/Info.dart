class Info {
  final String web;
  final String video;
  final String uuid;
  final String ip;
  final String name;

  Info(this.web, this.video, this.uuid, this.ip, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Info && runtimeType == other.runtimeType && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Info{web: $web, video: $video, uuid: $uuid, ip: $ip, name: $name}';
  }

  Info.fromJson(Map<String, dynamic> json)
      : web = json['web'],
        video = json['video'],
        uuid = json['uuid'],
        ip = json['ip'],
        name = json['name'];
}
