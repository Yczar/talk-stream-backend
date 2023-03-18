// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:talk_stream_backend/auth/data/models/user.dart';
import 'package:talk_stream_backend/chat/models/chat_message.dart';

class Chat {
  final String? lastMessage;
  final String? roomId;
  final User? user;
  final List<ChatMessage>? messages;
  final List<String>? members;
  final String? timeStamp;
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
    List<ChatMessage>? messages,
    List<String>? members,
    String? timeStamp,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'roomId': roomId,
      'user': user?.toMap(),
      'messages': messages?.map((x) => x.toJson()).toList(),
      'members': members,
      'timeStamp': timeStamp,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      messages: map['messages'] != null
          ? List<ChatMessage>.from(
              (map['messages'] as List).map<ChatMessage?>(
                (x) => ChatMessage.fromJson(x as String),
              ),
            )
          : null,
      members: map['members'] != null
          ? List<String>.from(map['members'] as List)
          : null,
      timeStamp: map['timeStamp'] != null ? map['timeStamp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(lastMessage: $lastMessage, roomId: $roomId, user: $user, messages: $messages, members: $members, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.lastMessage == lastMessage &&
        other.roomId == roomId &&
        other.user == user &&
        listEquals(other.messages, messages) &&
        listEquals(other.members, members) &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return lastMessage.hashCode ^
        roomId.hashCode ^
        user.hashCode ^
        messages.hashCode ^
        members.hashCode ^
        timeStamp.hashCode;
  }
}
