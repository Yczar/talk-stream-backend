import 'package:auth_data_source/core/services/src/user_service.dart';
import 'package:chat_data_source/chat_data_source.dart';
import 'package:dart_frog/dart_frog.dart';
// import 'package:talk_stream_backend/app/services/user_service.dart';
import 'package:talk_stream_backend/chat/cubit/chat_cubit.dart';

final _chat = ChatCubit();
ChatDatasourceImplementation _chatImplementation(UserService userService) =>
    ChatDatasourceImplementation(
      userService: userService,
    );

final chatProvider = provider<ChatCubit>((_) => _chat);
final chatImplementation = provider<ChatDatasource>(
  (context) => _chatImplementation(
    UserService(
      'users.json',
    ),
  ),
);
