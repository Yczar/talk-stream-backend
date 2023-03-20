import 'package:chat_data_source/src/models/chat.dart';

import 'models/message.dart';

abstract class ChatDatasource {
  Future<List<Chat>> getChats(String userId);
  Future<Message> sendMessage(Message message);
}
