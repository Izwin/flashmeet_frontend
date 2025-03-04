// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meet_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetEntity _$MeetEntityFromJson(Map<String, dynamic> json) => MeetEntity(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      attendees: (json['attendees'] as List<dynamic>)
          .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      admin: UserEntity.fromJson(json['admin'] as Map<String, dynamic>),
      isFinished: json['isFinished'] as bool,
      isCancelled: json['isCancelled'] as bool,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MeetEntityToJson(MeetEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'attendees': instance.attendees,
      'admin': instance.admin,
      'isFinished': instance.isFinished,
      'isCancelled': instance.isCancelled,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
