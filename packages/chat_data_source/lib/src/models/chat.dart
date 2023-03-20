// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_data_source/auth_data_source.dart';
import 'package:chat_data_source/src/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'chat.g.dart';

@immutable
@JsonSerializable()
class Chat extends Equatable {
  final String? lastMessage;
  final String? roomId;
  final User? user;
  final List<Message>? messages;
  final List<String>? members;
  final DateTime? timeStamp;
  Chat({
    this.lastMessage,
    this.roomId,
    this.user,
    this.messages,
    this.members,
    this.timeStamp,
  });

  Chat copyWith({
    String? lastMessage,
    String? roomId,
    User? user,
    List<Message>? messages,
    List<String>? members,
    DateTime? timeStamp,
  }) {
    return Chat(
      lastMessage: lastMessage ?? this.lastMessage,
      roomId: roomId ?? this.roomId,
      user: user ?? this.user,
      messages: messages ?? this.messages,
      members: members ?? this.members,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  List<Object?> get props {
    return [
      lastMessage,
      roomId,
      user,
      messages,
      members,
      timeStamp,
    ];
  }

  static Chat fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
