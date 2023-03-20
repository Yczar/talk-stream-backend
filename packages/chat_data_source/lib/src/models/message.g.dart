// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      sender: json['sender'] as String?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      roomId: json['roomId'] as String?,
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'sender': instance.sender,
      'message': instance.message,
      'timestamp': instance.timestamp?.toIso8601String(),
      'roomId': instance.roomId,
      'members': instance.members,
    };
