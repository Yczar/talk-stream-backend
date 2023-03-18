import 'package:broadcast_bloc/broadcast_bloc.dart';

class ChatCubit extends BroadcastCubit<String> {
  ChatCubit() : super('');

  void sendMessage() => emit(state);
}
