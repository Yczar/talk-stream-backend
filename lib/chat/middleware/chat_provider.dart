import 'package:auth_data_source/core/services/src/user_service.dart';
import 'package:chat_data_source/chat_data_source.dart';
import 'package:dart_frog/dart_frog.dart';
// import 'package:talk_stream_backend/app/services/user_service.dart';
import 'package:talk_stream_backend/chat/cubit/chat_cubit.dart';

/// Creates an instance of the ChatCubit class and assigns it to the private
/// variable _chat.
final _chat = ChatCubit();

/// Defines a callback function that takes a userService object as an argument
/// and returns a ChatDatasourceImplementation object.
ChatDatasourceImplementation _chatImplementation(UserService userService) =>
    ChatDatasourceImplementation(
      userService: userService,
    );

/// Creates a provider that returns an instance of the ChatCubit class when
/// called.
final chatProvider = provider<ChatCubit>((_) => _chat);

/// Creates a provider that returns an instance of the
/// ChatDatasourceImplementation class when called.
/// The provider function takes a context parameter, which is not used here.
/// The provider function calls the _chatImplementation function defined
/// earlier to create a ChatDatasourceImplementation instance.
/// The _chatImplementation function takes a UserService instance as an
/// argument, which is created here with the file path 'users.json'.
final chatImplementation = provider<ChatDatasource>(
  (context) => _chatImplementation(
    UserService(
      'users.json',
    ),
  ),
);
