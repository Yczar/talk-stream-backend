// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      lastMessage: json['lastMessage'] as String?,
      roomId: json['roomId'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
      timeStamp: json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'] as String),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'lastMessage': instance.lastMessage,
      'roomId': instance.roomId,
      'user': instance.user,
      'messages': instance.messages,
      'members': instance.members,
      'timeStamp': instance.timeStamp?.toIso8601String(),
    };
