// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      lastName: json['last_name'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      photoUrl: json['photo_url'] as String?,
      titleProfession: json['title_profession'] as String?,
      quote: json['quote'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'state': instance.state,
      'zip': instance.zip,
      'photo_url': instance.photoUrl,
      'title_profession': instance.titleProfession,
      'quote': instance.quote,
    };
