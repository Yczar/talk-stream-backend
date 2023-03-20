// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:io';

import 'package:auth_data_source/auth_data_source.dart';
import 'package:chat_data_source/chat_data_source.dart';
import 'package:crypto/crypto.dart';

class ChatService {
  ChatService(
    this._fileName,
    this.userService,
  ) {
    _createFileIfNotExists();
  }
  final String _fileName;
  final UserService userService;

  // final String filePath;

  Future<List<Chat>> getChatRooms(String userId) async {
    final users = await userService.getUsers();
    final messages = await _getAllMessages();
    final messagesByRoomId = messages.fold<Map<String, List<Message>>>(
      {},
      (Map<String, List<Message>> map, message) {
        final roomId = message.roomId;
        if (roomId == null) return map;
        if (!(message.members?.contains(userId) ?? false)) return map;
        final messagesForRoom = map[roomId] ?? [];
        messagesForRoom.add(message);
        return map..[roomId] = messagesForRoom;
      },
    );
    return messagesByRoomId.entries.map((entry) {
      final value = entry.value;
      final otherUserId = value.last.members?.firstWhere((id) => id != userId);
      final otherUser = users.firstWhere((usr) => otherUserId == usr.id);
      return Chat(
        roomId: entry.key,
        lastMessage: value.last.message,
        members: value.first.members,
        messages: value,
        timeStamp: value.last.timestamp,
        user: otherUser,
      );
    }).toList();
  }

  Future<void> saveMessage(Message message) async {
    final file = File('messages.json');
    final messages = <Message>[];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List).map((content) {
        final decodedValue = content as Map<String, dynamic>;

        return decodedValue;
      }).toList();

      for (final messageJson in json) {
        messages.add(Message.fromJson(messageJson));
      }
    }
    messages.add(message);
    await file
        .writeAsString(jsonEncode(messages.map((e) => e.toJson()).toList()));
  }

  Future<List<Message>> _getAllMessages() async {
    final file = File('messages.json');
    final messages = <Message>[];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List).map((content) {
        final decodedValue = content as Map<String, dynamic>;

        return decodedValue;
      }).toList();

      for (final messageJson in json) {
        messages.add(Message.fromJson(messageJson));
      }
    }

    return messages;
  }

  Future<void> _createFileIfNotExists() async {
    final file = File(_fileName);
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('[]');
    }
  }

  String generateChatRoomId(String value1, String value2) {
    // sort the two strings alphabetically
    final values = <String>[value1, value2]..sort();

    // concatenate the two sorted strings
    final concatenated = '${values[0]}-${values[1]}';

    // generate a SHA-1 hash of the concatenated string
    final bytes = utf8.encode(concatenated);
    final digest = sha1.convert(bytes);

    // return the hash as a string
    return digest.toString();
  }

  List<String> revertChatRoomId(String chatRoomId) {
    // generate the original concatenated string
    final bytes = utf8.encode(chatRoomId);
    final originalConcatenated = utf8.decode(bytes);

    // split the original concatenated string into two parts using the hyphen separator
    final values = originalConcatenated.split('-');

    // return the two parts as a list
    return values;
  }
}
