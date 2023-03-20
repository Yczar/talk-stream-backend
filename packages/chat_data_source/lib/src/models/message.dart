// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'message.g.dart';

@immutable
@JsonSerializable()
class Message extends Equatable {
  final String? sender;
  final String? message;
  final DateTime? timestamp;
  final String? roomId;
  final List<String>? members;
  Message({
    this.sender,
    this.message,
    this.timestamp,
    this.roomId,
    this.members,
  });

  Message copyWith({
    String? sender,
    String? message,
    DateTime? timestamp,
    String? roomId,
    List<String>? members,
  }) {
    return Message(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      roomId: roomId ?? this.roomId,
      members: members ?? this.members,
    );
  }

  @override
  List<Object?> get props {
    return [
      sender,
      message,
      timestamp,
      roomId,
      members,
    ];
  }

  static Message fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
