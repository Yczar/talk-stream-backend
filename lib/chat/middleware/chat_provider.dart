import 'package:dart_frog/dart_frog.dart';
import 'package:talk_stream_backend/chat/cubit/chat_cubit.dart';

final _chat = ChatCubit();

final chatProvider = provider<ChatCubit>((_) => _chat);
