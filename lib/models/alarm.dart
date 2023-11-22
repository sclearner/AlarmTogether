import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  final String? groupID;
  final String? authorID;
  final String? title;
  final Set<String> affectID;
  final DateTime time;
  final List<bool> isRepeated;
  final String? ringTone;
  final String? message;

  Alarm(
      {this.title,
        this.groupID,
      this.authorID,
      this.affectID = const <String>{},
      required this.time,
      this.isRepeated = const [false, false, false, false, false, false, false],
      this.ringTone,
      this.message})
      : assert(isRepeated.length == 7);

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmToJson(this);
}
