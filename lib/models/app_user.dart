import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String? id;
  final String? displayName;
  final String? email;
  final DateTime? dateOfBirth;
  final String? phone;

  AppUser({this.displayName, this.id, this.email, this.dateOfBirth, this.phone});

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}