// 这个文件是 "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// 必要的：关联 `main.dart` 到 Freezed 代码生成器
part 'person.freezed.dart';

// 可选的：因为 Person 类是可序列化的，所以我们必须添加这一行。
// 但是如果 Person 不是可序列化的，我们可以跳过它。
part 'person.g.dart';

@unfreezed
abstract class Person with _$Person {
  const Person._();

  factory Person({
    @Default("") String web,
    @Default("") String video,
    @Default("") String uuid,
    @Default("") String ip,
    @Default("") String name,
    @Default("") String source,
    @Default("") String device,
    @Default("") String code,
    @Default("") String type,
    dynamic appversion,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json) => _$PersonFromJson(json);

  @override
  int get hashCode => uuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && uuid == other.uuid;
}
