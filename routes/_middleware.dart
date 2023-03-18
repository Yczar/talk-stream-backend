import 'package:dart_frog/dart_frog.dart';
import 'package:talk_stream_backend/chat/middleware/chat_provider.dart';

Handler middleware(Handler handler) => handler.use(chatProvider);
