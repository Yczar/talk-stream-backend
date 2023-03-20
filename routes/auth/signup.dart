import 'dart:async';
import 'dart:io';

import 'package:auth_data_source/auth_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

/// Handles incoming HTTP requests and returns a response.
///
/// If the request method is not allowed, a [Response] with status code
/// 405 (Method Not Allowed) is returned. Otherwise, the appropriate method
/// handler is called based on the request method.
///
/// For POST requests, the [_post] method is called, which attempts to sign
/// up the user and returns a [Response] with the appropriate status code and
/// body. If an [AuthException] is thrown during sign up, a [Response] with
/// status code 400 (Bad Request) and a JSON body containing an error message
/// is returned. If any other exception is thrown, a [Response] with status code
/// 400 (Bad Request) and a JSON body containing the exception message is
/// returned.
///
/// Throws a [SignUpException] with message "invalid data" if the request
/// body is empty.
///
/// Returns a [FutureOr<Response>] object representing the response to the
/// HTTP request.
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

/// A [Response] object with status code 405 (Method Not Allowed).
final _methodNotAllowedResponse = Response(
  statusCode: HttpStatus.methodNotAllowed,
);

/// Attempts to sign up the user based on the data in the request body and
/// returns a [Response] with the appropriate status code and body.
///
/// Throws an [AuthException] with the error message if an error occurs during
/// sign up.
///
/// Returns a [Future<Response>] object representing the response to the
/// HTTP request.
Future<Response> _post(RequestContext context) async {
  try {
    final dataSource = context.read<AuthDataSource>();
    final requestBody = await context.request.body();

    if (requestBody.isEmpty) {
      throw SignUpException('invalid data');
    }
    final userJson = await context.request.json();
    final user = User.fromJson(userJson as Map<String, dynamic>);
    final signup = await dataSource.signUp(user);
    return Response.json(
      body: signup..toJson(),
    );
  } on AuthException catch (e) {
    // print(e);
    // print(s);
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'message': e.toString(),
      },
    );
  } catch (e) {
    // print(s);
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'message': e.toString(),
      },
    );
  }
}
