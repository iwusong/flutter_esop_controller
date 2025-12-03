// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Info implements DiagnosticableTreeMixin {
  String get web;
  set web(String value);
  String get video;
  set video(String value);
  String get uuid;
  set uuid(String value);
  String get ip;
  set ip(String value);
  String get name;
  set name(String value);
  String get source;
  set source(String value);
  String get device;
  set device(String value);
  String get SM2D;
  set SM2D(String value);
  @JsonKey(name: 'devicesInfo')
  List<DeviceItem> get devicesList;
  @JsonKey(name: 'devicesInfo')
  set devicesList(List<DeviceItem> value);
  String get code;
  set code(String value);
  String get type;
  set type(String value);
  int get appversion;
  set appversion(int value);

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InfoCopyWith<Info> get copyWith =>
      _$InfoCopyWithImpl<Info>(this as Info, _$identity);

  /// Serializes this Info to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Info'))
      ..add(DiagnosticsProperty('web', web))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('ip', ip))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('device', device))
      ..add(DiagnosticsProperty('SM2D', SM2D))
      ..add(DiagnosticsProperty('devicesList', devicesList))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('appversion', appversion));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Info(web: $web, video: $video, uuid: $uuid, ip: $ip, name: $name, source: $source, device: $device, SM2D: $SM2D, devicesList: $devicesList, code: $code, type: $type, appversion: $appversion)';
  }
}

/// @nodoc
abstract mixin class $InfoCopyWith<$Res> {
  factory $InfoCopyWith(Info value, $Res Function(Info) _then) =
      _$InfoCopyWithImpl;
  @useResult
  $Res call(
      {String web,
      String video,
      String uuid,
      String ip,
      String name,
      String source,
      String device,
      String SM2D,
      @JsonKey(name: 'devicesInfo') List<DeviceItem> devicesList,
      String code,
      String type,
      int appversion});
}

/// @nodoc
class _$InfoCopyWithImpl<$Res> implements $InfoCopyWith<$Res> {
  _$InfoCopyWithImpl(this._self, this._then);

  final Info _self;
  final $Res Function(Info) _then;

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? web = null,
    Object? video = null,
    Object? uuid = null,
    Object? ip = null,
    Object? name = null,
    Object? source = null,
    Object? device = null,
    Object? SM2D = null,
    Object? devicesList = null,
    Object? code = null,
    Object? type = null,
    Object? appversion = null,
  }) {
    return _then(_self.copyWith(
      web: null == web
          ? _self.web
          : web // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _self.video
          : video // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _self.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      device: null == device
          ? _self.device
          : device // ignore: cast_nullable_to_non_nullable
              as String,
      SM2D: null == SM2D
          ? _self.SM2D
          : SM2D // ignore: cast_nullable_to_non_nullable
              as String,
      devicesList: null == devicesList
          ? _self.devicesList
          : devicesList // ignore: cast_nullable_to_non_nullable
              as List<DeviceItem>,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      appversion: null == appversion
          ? _self.appversion
          : appversion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Info].
extension InfoPatterns on Info {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Info value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Info() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Info value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Info():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Info value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Info() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String web,
            String video,
            String uuid,
            String ip,
            String name,
            String source,
            String device,
            String SM2D,
            @JsonKey(name: 'devicesInfo') List<DeviceItem> devicesList,
            String code,
            String type,
            int appversion)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Info() when $default != null:
        return $default(
            _that.web,
            _that.video,
            _that.uuid,
            _that.ip,
            _that.name,
            _that.source,
            _that.device,
            _that.SM2D,
            _that.devicesList,
            _that.code,
            _that.type,
            _that.appversion);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String web,
            String video,
            String uuid,
            String ip,
            String name,
            String source,
            String device,
            String SM2D,
            @JsonKey(name: 'devicesInfo') List<DeviceItem> devicesList,
            String code,
            String type,
            int appversion)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Info():
        return $default(
            _that.web,
            _that.video,
            _that.uuid,
            _that.ip,
            _that.name,
            _that.source,
            _that.device,
            _that.SM2D,
            _that.devicesList,
            _that.code,
            _that.type,
            _that.appversion);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String web,
            String video,
            String uuid,
            String ip,
            String name,
            String source,
            String device,
            String SM2D,
            @JsonKey(name: 'devicesInfo') List<DeviceItem> devicesList,
            String code,
            String type,
            int appversion)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Info() when $default != null:
        return $default(
            _that.web,
            _that.video,
            _that.uuid,
            _that.ip,
            _that.name,
            _that.source,
            _that.device,
            _that.SM2D,
            _that.devicesList,
            _that.code,
            _that.type,
            _that.appversion);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Info extends Info with DiagnosticableTreeMixin {
  _Info(
      {this.web = "",
      this.video = "",
      this.uuid = "",
      this.ip = "",
      this.name = "",
      this.source = "",
      this.device = "",
      this.SM2D = "",
      @JsonKey(name: 'devicesInfo') this.devicesList = const [],
      this.code = "",
      this.type = "",
      this.appversion = 0})
      : super._();
  factory _Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  @override
  @JsonKey()
  String web;
  @override
  @JsonKey()
  String video;
  @override
  @JsonKey()
  String uuid;
  @override
  @JsonKey()
  String ip;
  @override
  @JsonKey()
  String name;
  @override
  @JsonKey()
  String source;
  @override
  @JsonKey()
  String device;
  @override
  @JsonKey()
  String SM2D;
  @override
  @JsonKey(name: 'devicesInfo')
  List<DeviceItem> devicesList;
  @override
  @JsonKey()
  String code;
  @override
  @JsonKey()
  String type;
  @override
  @JsonKey()
  int appversion;

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InfoCopyWith<_Info> get copyWith =>
      __$InfoCopyWithImpl<_Info>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InfoToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Info'))
      ..add(DiagnosticsProperty('web', web))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('ip', ip))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('device', device))
      ..add(DiagnosticsProperty('SM2D', SM2D))
      ..add(DiagnosticsProperty('devicesList', devicesList))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('appversion', appversion));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Info(web: $web, video: $video, uuid: $uuid, ip: $ip, name: $name, source: $source, device: $device, SM2D: $SM2D, devicesList: $devicesList, code: $code, type: $type, appversion: $appversion)';
  }
}

/// @nodoc
abstract mixin class _$InfoCopyWith<$Res> implements $InfoCopyWith<$Res> {
  factory _$InfoCopyWith(_Info value, $Res Function(_Info) _then) =
      __$InfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String web,
      String video,
      String uuid,
      String ip,
      String name,
      String source,
      String device,
      String SM2D,
      @JsonKey(name: 'devicesInfo') List<DeviceItem> devicesList,
      String code,
      String type,
      int appversion});
}

/// @nodoc
class __$InfoCopyWithImpl<$Res> implements _$InfoCopyWith<$Res> {
  __$InfoCopyWithImpl(this._self, this._then);

  final _Info _self;
  final $Res Function(_Info) _then;

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? web = null,
    Object? video = null,
    Object? uuid = null,
    Object? ip = null,
    Object? name = null,
    Object? source = null,
    Object? device = null,
    Object? SM2D = null,
    Object? devicesList = null,
    Object? code = null,
    Object? type = null,
    Object? appversion = null,
  }) {
    return _then(_Info(
      web: null == web
          ? _self.web
          : web // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _self.video
          : video // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _self.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      device: null == device
          ? _self.device
          : device // ignore: cast_nullable_to_non_nullable
              as String,
      SM2D: null == SM2D
          ? _self.SM2D
          : SM2D // ignore: cast_nullable_to_non_nullable
              as String,
      devicesList: null == devicesList
          ? _self.devicesList
          : devicesList // ignore: cast_nullable_to_non_nullable
              as List<DeviceItem>,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      appversion: null == appversion
          ? _self.appversion
          : appversion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
