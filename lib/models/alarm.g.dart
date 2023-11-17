// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      title: json['title'] as String?,
      groupID: json['groupID'] as String?,
      authorID: json['authorID'] as String?,
      affectID: (json['affectID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      time: DateTime.parse(json['time'] as String),
      isRepeated: (json['isRepeated'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          const [false, false, false, false, false, false, false],
      ringTone: json['ringTone'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'groupID': instance.groupID,
      'authorID': instance.authorID,
      'title': instance.title,
      'affectID': instance.affectID,
      'time': instance.time.toIso8601String(),
      'isRepeated': instance.isRepeated,
      'ringTone': instance.ringTone,
      'message': instance.message,
    };
