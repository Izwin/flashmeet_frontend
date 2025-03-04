// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) =>
    MessageEntity(
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sender: UserEntity.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'sender': instance.sender,
    };
