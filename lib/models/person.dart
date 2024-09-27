import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  final int? id;
  final String? name;
  final String? lastName;
  final String? birthday;
  final String? gender;
  final String? state;
  final String? zip;
  final String? photoUrl;
  final String? titleProfession;
  final String? quote;

  Person({
    this.id,
    this.name,
    this.lastName,
    this.birthday,
    this.gender,
    this.state,
    this.zip,
    this.photoUrl,
    this.titleProfession,
    this.quote,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
