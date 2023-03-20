import 'dart:convert';

import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:chat_data_source/chat_data_source.dart';

class ChatCubit extends BroadcastCubit<String> {
  ChatCubit() : super('');

  void sendMessage(String event, ChatDatasource chatDatasource) {
    if (event.contains('sender')) {
      chatDatasource.sendMessage(
          Message.fromJson(jsonDecode(event) as Map<String, dynamic>));
    }
    emit(event);
  }
}
