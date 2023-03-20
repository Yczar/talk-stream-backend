import 'dart:async';
import 'dart:io';

import 'package:auth_data_source/auth_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

/// Handles incoming HTTP requests and returns an appropriate response
/// based on the request method.
///
/// If the request method is not allowed, this function returns a 405
/// Method Not Allowed response.
///
/// If the request method is POST, it attempts to sign in the user by calling
/// the signIn function of the [AuthDataSource] and returns a JSON response
/// with the user data if successful.
///
/// If the request method is POST and the request body is empty or invalid,
/// it throws a [SignInException] with an 'invalid data' message.
///
/// If the request method is POST and the user authentication fails, it
/// catches an [AuthException] and returns a JSON response with the error message.
///
/// If any other error occurs during the execution of the function, it
/// catches the error and returns a JSON response with the error message.
FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _methodNotAllowedResponse;
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
      return _methodNotAllowedResponse;
    case HttpMethod.head:
      return _methodNotAllowedResponse;
    case HttpMethod.options:
      return _methodNotAllowedResponse;
    case HttpMethod.patch:
      return _methodNotAllowedResponse;
    case HttpMethod.put:
      return _methodNotAllowedResponse;
  }
}

/// A 405 Method Not Allowed response.
final _methodNotAllowedResponse = Response(
  statusCode: HttpStatus.methodNotAllowed,
);

/// Attempts to sign in the user by calling the signIn function of the
/// [AuthDataSource] and returns a JSON response with the user data
/// if successful.
///
/// If the request body is empty or invalid, it throws a [SignInException]
/// with an 'invalid data' message.
///
/// If the user authentication fails, it catches an [AuthException]
/// and returns a JSON response with the error message.
///
/// If any other error occurs during the execution of the function,
/// it catches the error and returns a JSON response with the error message.
Future<Response> _post(RequestContext context) async {
  try {
    final dataSource = context.read<AuthDataSource>();
    final requestBody = await context.request.body();
    if (requestBody.isEmpty) {
      throw SignInException('invalid data');
    }
    print(requestBody);
    final userJson = await context.request.json();
    final user = User.fromJson(
      userJson as Map<String, dynamic>,
    );

    return Response.json(
      statusCode: HttpStatus.ok,
      body: (await dataSource.signIn(user)).toJson(),
    );
  } on AuthException catch (e) {
    return Response.json(statusCode: HttpStatus.badRequest, body: {
      'message': e.toString(),
    });
  } catch (e, s) {
    print(s);
    return Response.json(statusCode: HttpStatus.badRequest, body: {
      'message': e.toString(),
    });
  }
}
