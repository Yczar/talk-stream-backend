import 'package:dart_frog/dart_frog.dart';
import 'package:talk_stream_backend/auth/middleware/auth_provider.dart';
import 'package:talk_stream_backend/chat/middleware/chat_provider.dart';

Handler middleware(Handler handler) => handler
    .use(requestLogger())
    .use(authProvider)
    .use(chatProvider)
    .use(chatImplementation);
