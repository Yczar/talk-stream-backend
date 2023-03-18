import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:talk_stream_backend/app/services/user_service.dart';

import '../../chat/models/chat.dart';
import '../../chat/models/chat_message.dart';

class ChatService {
  ChatService(this._fileName) {
    _createFileIfNotExists();
  }
  final String _fileName;

  // final String filePath;

  Future<List<Chat>> loadChatRooms(
    String userId,
    UserService userService,
  ) async {
    try {
      final file = File(_fileName);
      if (!await file.exists()) {
        await file.create(recursive: true);
        await file.writeAsString('{}');
      }

      final users = await userService.getUsers();
      final contents = await file.readAsString();
      final chatRoomLists = json.decode(contents) as List?;
      // final user = print(chatRoomLists);
      final associatedUserRooms = chatRoomLists
          ?.map((roomMap) => Chat.fromJson(roomMap as String))
          .where((room) => room.members?.contains(userId) ?? false)
          .map((chat) {
        final otherId =
            chat.members?.firstWhereOrNull((member) => member != userId);
        final user = users.firstWhereOrNull((usr) => usr.userId == otherId);
        return chat.copyWith(
          user: user,
        );
      }).toList();
      // final messagesJson = jsonMap[roomId] as List?;

      print('Chat Rooms $associatedUserRooms');
      if (associatedUserRooms == null) {
        return [];
      }
      // final messages = messagesList
      //     .map(
      //       (message) => ChatMessage.fromJson(message as Map<String, dynamic>),
      //     )
      //     .toList();
      // print('Messages $associatedUserRooms');
      return associatedUserRooms;
    } catch (e, s) {
      print('Error loading messages: $e $s');
      return [];
    }
  }

  Future<Chat?> getChat(String roomId) async {
    final file = File(_fileName);
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('{}');
    }
    // final splitte
    final contents = await file.readAsString();
    final chatRoomLists = json.decode(contents) as List?;
    final room = chatRoomLists
        ?.map((roomMap) => Chat.fromJson(roomMap as String))
        .firstWhereOrNull((room) => (room.roomId ?? '') == roomId);
    return room;
  }
// [
//     {
//         "members": ["user1","user2"],
//         "lastMessage":"hello",
//         "roomId": "id",
//         "user": {
//         },
//         "messages": [

//         ],
//         "timeStamp":""
//     }
// ]
  Future<void> saveMessages(
    ChatMessage message,
  ) async {
    try {
      final file = File(_fileName);
      final chat = await getChat(message.roomId ?? '');
      final chatRoomIdExists = chat != null;
      final chats = <Chat>[];
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List)
          .map(
            (content) => jsonDecode(content as String) as Map<String, dynamic>,
          )
          .toList();

      for (final chatJson in json) {
        chats.add(
          Chat(
            lastMessage: chatJson['lastMessage'] as String?,
            members: (chatJson['members'] as List?)
                ?.map((e) => e as String)
                .toList(),
            messages: (chatJson['messages'] as List?)
                ?.map(
                  (e) => ChatMessage.fromMap(
                    jsonDecode(e as String) as Map<String, dynamic>,
                  ),
                )
                .toList(),
            roomId: chatJson['roomId'] as String?,
            timeStamp: chatJson['timeStamp'] as String?,
          ),
        );
      }
      print(chatRoomIdExists);
      if (chatRoomIdExists) {
        final cht = chats.where((chat) => chat.roomId == message.roomId);
        print(cht);
        chats
          ..removeWhere((u) => u.roomId == message.roomId)
          ..add(chat.copyWith(messages: [...?chat.messages, message]));
        await file
            .writeAsString(jsonEncode(chats.map((e) => e.toJson()).toList()));
        return;
      }
      // final messages = await loadMessages(message.roomId ?? '');
      // final jsonList = messages.map((message) => message.toJson()).toList()
      //   ..add(message.toJson());
      chats.add(
        Chat(
          lastMessage: message.message,
          members: message.members,
          messages: [message],
          roomId: generateChatRoomId(
            message.members?[0] ?? '',
            message.members?[1] ?? '',
          ),
        ),
      );
      await file
          .writeAsString(jsonEncode(chats.map((e) => e.toJson()).toList()));
    } catch (e, s) {
      print('Error saving messages: $e $s');
    }
  }

  Future<void> _createFileIfNotExists() async {
    final file = File(_fileName);
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('[]');
      print('Created');
    }
    print('Exists');
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
