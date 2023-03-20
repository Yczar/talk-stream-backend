import 'package:chat_data_source/chat_data_source.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:talk_stream_backend/chat/cubit/chat_cubit.dart';

Future<Response> onRequest(RequestContext context) async {
  final dataSource = context.read<ChatDatasource>();
  final handler = webSocketHandler(
    (channel, protocol) {
      final cubit = context.read<ChatCubit>()..subscribe(channel);

      channel.stream.listen(
        (event) {
          cubit.sendMessage(event as String, dataSource);
        },
        onDone: () => cubit.unsubscribe(channel),
      );
    },
  );

  return handler(context);
}

// extension on String {
//   ChatSocketType? toMessage() {
//     for (final message in ChatSocketType.values) {
//       if (this == message.value) {
//         return message;
//       }
//     }
//     return null;
//   }
// }
