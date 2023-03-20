import 'dart:convert';

import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:chat_data_source/chat_data_source.dart';

/// Defines a ChatCubit class that extends the BroadcastCubit<String> class.
class ChatCubit extends BroadcastCubit<String> {
  /// Constructs a ChatCubit object and calls the super constructor with an
  /// empty string as the initial state.
  ChatCubit() : super('');

  /// Defines a sendMessage method that takes an event string and a
  /// chatDatasource object as arguments.
  void sendMessage(String event, ChatDatasource chatDatasource) {
    // Checks if the event string contains the 'sender' substring.
    if (event.contains('sender')) {
      // If the event is a message sent by a sender, decode the event as a
      //Message object using JSON decoding and pass it to the chatDatasource's
      //sendMessage method.
      chatDatasource.sendMessage(
        Message.fromJson(jsonDecode(event) as Map<String, dynamic>),
      );
    }
    // Emits the event string to all listeners.
    emit(event);
  }
}
