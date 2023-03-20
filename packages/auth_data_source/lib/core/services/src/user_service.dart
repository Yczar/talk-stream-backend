// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:io';

import '../../../src/models/user.dart';

class UserService {
  UserService(this._fileName) {
    _createFileIfNotExists();
  }
  final String _fileName;

  Future<List<User>> getUsers([String? userId]) async {
    final file = File(_fileName);
    final users = <User>[];
    final fileExists = await file.exists();
    if (fileExists) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List)
          .map(
            (content) => content as Map<String, dynamic>,
          )
          .toList();

      for (final userJson in json) {
        users.add(
          User(
            id: userJson['id'] as String,
            name: userJson['name'] as String,
            password: userJson['password'] as String,
            email: userJson['email'] as String,
            profileImage: userJson['profileImage'] as String,
          ),
        );
      }
    }
    if (userId != null)
      return users.where((user) => user.id != userId).toList();
    return users;
  }

  Future<void> addUser(User user) async {
    final file = File(_fileName);
    final users = <User>[];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List).map((content) {
        final decodedValue = content as Map<String, dynamic>;

        return decodedValue;
      }).toList();

      for (final userJson in json) {
        users.add(
          User(
            id: userJson['id'] as String,
            name: userJson['name'] as String,
            password: userJson['password'] as String,
            email: userJson['email'] as String,
            profileImage: userJson['profileImage'] as String,
          ),
        );
      }
    }

    users.add(user);
    await file.writeAsString(jsonEncode(users.map((e) => e.toJson()).toList()));
  }

  Future<void> updateUser(User user) async {
    final file = File(_fileName);
    final users = <User>[];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List)
          .map((content) => content as Map<String, dynamic>)
          .toList();

      for (final userJson in json) {
        users.add(
          User(
            id: userJson['id'] as String,
            name: userJson['name'] as String,
            password: userJson['password'] as String,
            email: userJson['email'] as String,
            profileImage: userJson['profileImage'] as String,
          ),
        );
      }
    }

    users
      ..removeWhere((u) => u.email == user.email)
      ..add(user);
    await file.writeAsString(jsonEncode(users.map((e) => e.toJson()).toList()));
  }

  Future<void> _createFileIfNotExists() async {
    final file = File(_fileName);
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('[]');
    }
  }
}
