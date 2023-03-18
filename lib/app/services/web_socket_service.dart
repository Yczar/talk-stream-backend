// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketService();

  // final String url;
  final List<WebSocketChannel> activeChannels = [];

  void updateChannels(WebSocketChannel channel) {
    activeChannels.add(channel);
  }

  void send(dynamic data) {
    final message = jsonEncode(data);
    for (final activeChannel in activeChannels) {
      activeChannel.sink.add(message);
    }
  }

  void dispose(WebSocketChannel channel) {
    activeChannels.remove(channel);
    channel.sink.close();
    channel.stream.drain();
  }
}
