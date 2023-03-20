import 'dart:async';
import 'dart:io';

import 'package:chat_data_source/chat_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final userId = context.request.headers['userId'];
  switch (context.request.method) {
    case HttpMethod.get:
      return _getChats(context, userId);
    case HttpMethod.post:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return _methodNotAllowedResponse;
  }
}

/// The response returned when the HTTP method is not allowed for the current
/// request.
final _methodNotAllowedResponse = Response(
  statusCode: HttpStatus.methodNotAllowed,
);
Future<Response> _getChats(
  RequestContext context,
  String? userId,
) async {
  try {
    final dataSource = context.read<ChatDatasource>();
    if (userId == null) {
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: {
          'message': 'userId required',
        },
      );
    }
    final chats = await dataSource.getChats(userId);
    return Response.json(
      body: chats,
    );
  } catch (e) {
    // Log the error stack trace and return a JSON response with an error
    // message.
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'message': e.toString(),
      },
    );
  }
}
