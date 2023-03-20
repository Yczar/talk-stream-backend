// ignore_for_file: public_member_api_docs
import 'dart:convert';

class ChatMessage {
  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.roomId,
    this.members,
  });
  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map['sender'] != null ? map['sender'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int)
          : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      members: map['members'] != null
          ? List<String>.from(map['members'] as List)
          : null,
    );
  }

  final String? sender;
  final String? message;
  final DateTime? timestamp;
  final String? roomId;
  final List<String>? members;

  ChatMessage copyWith({
    String? sender,
    String? message,
    DateTime? timestamp,
    String? roomId,
    List<String>? members,
  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      roomId: roomId ?? this.roomId,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'message': message,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'roomId': roomId,
      'members': members,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ChatMessage(sender: $sender, message: $message, timestamp: '
        '$timestamp, roomId: $roomId, members: $members)';
  }
}
