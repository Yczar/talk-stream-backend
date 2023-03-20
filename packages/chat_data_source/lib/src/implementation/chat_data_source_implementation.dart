import 'package:auth_data_source/auth_data_source.dart';
import 'package:chat_data_source/chat_data_source.dart';
import 'package:chat_data_source/core/services/services.dart';

class ChatDatasourceImplementation extends ChatDatasource {
  ChatDatasourceImplementation({
    this.databaseFileName = 'chat.json',
    required this.userService,
  }) : chatService = ChatService(databaseFileName, userService);
  final ChatService chatService;
  final UserService userService;
  final String databaseFileName;
  @override
  Future<List<Chat>> getChats(String userId) async {
    return (await chatService.getChatRooms(
      userId,
    ));
  }

  @override
  Future<Message> sendMessage(Message message) async {
    final updMessage = message.copyWith(
        roomId: chatService.generateChatRoomId(
      message.members!.first,
      message.members!.last,
    ));
    await chatService.saveMessage(updMessage);
    return updMessage;
  }
}
