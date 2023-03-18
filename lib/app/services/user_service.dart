import 'dart:convert';
import 'dart:io';

import '../../auth/data/models/user.dart';

class UserService {
  UserService(this._fileName) {
    _createFileIfNotExists();
  }
  final String _fileName;

  Future<List<User>> getUsers() async {
    final file = File(_fileName);
    final users = <User>[];
    final fileExists = await file.exists();
    if (fileExists) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List)
          .map(
            (content) => jsonDecode(content as String) as Map<String, dynamic>,
          )
          .toList();

      for (final userJson in json) {
        users.add(
          User(
            userId: userJson['userId'] as String,
            name: userJson['name'] as String,
            password: userJson['password'] as String,
            email: userJson['email'] as String,
            profilePicture: userJson['profilePicture'] as String,
          ),
        );
      }
    }

    return users;
  }

  Future<void> addUser(User user) async {
    final file = File(_fileName);
    final users = <User>[];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final json = (jsonDecode(contents) as List).map((content) {
        final decodedValue =
            jsonDecode(content as String) as Map<String, dynamic>;
        print(decodedValue);
        return decodedValue;
      }).toList();

      for (final userJson in json) {
        users.add(
          User(
            userId: userJson['userId'] as String,
            name: userJson['name'] as String,
            password: userJson['password'] as String,
            email: userJson['email'] as String,
            profilePicture: userJson['profilePicture'] as String,
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
            userId: userJson['userId'] as String,
            name: userJson['name'] as String,
            password: userJson['password'] as String,
            email: userJson['email'] as String,
            profilePicture: userJson['profilePicture'] as String,
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
      print('Created');
    }
    print('Exists');
  }
}
