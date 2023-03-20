import 'dart:async';
import 'dart:io';

import 'package:auth_data_source/auth_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

/// Handles incoming HTTP requests and returns an appropriate response based on
/// the HTTP method.
///
/// If the request method is `GET`, the [_getUsers] method is called to fetch a
/// list of users and return it as a JSON response. If the method is anything
/// else, a `405 Method Not Allowed` response is returned.
///
/// Throws a `HttpException` if an error occurs while processing the request.
FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getUsers(context);
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

/// Fetches a list of users and returns it as a JSON response.
///
/// If an error occurs while fetching the users, a `400 Bad Request` response
/// with an error message is returned.
Future<Response> _getUsers(RequestContext context) async {
  try {
    final headers = context.request.headers;
    final userId = headers['userId'];
    if (userId == null) {
      throw GetUsersException('please pass in your user id');
    }
    final dataSource = context.read<AuthDataSource>();
    final users = await dataSource.getUsers(userId.toString());

    return Response.json(
      statusCode: HttpStatus.ok,
      body: users,
    );
  } catch (e) {
    // Log the error stack trace and return a JSON response with an error message.
    // print(s);
    return Response.json(statusCode: HttpStatus.badRequest, body: {
      'message': e.toString(),
    });
  }
}
