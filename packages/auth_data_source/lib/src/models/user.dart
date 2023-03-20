import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../core/services/src/user_service.dart';
part 'user.g.dart';

/// A class representing a user.
@immutable
@JsonSerializable()
class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.username,
    this.password,
  });

  /// The unique identifier of the user.
  final String? id;

  /// The name of the user.
  final String? name;

  /// The email address of the user.
  final String? email;

  /// The URL of the user's profile image.
  final String? profileImage;

  /// The username of the user.
  final String? username;

  /// The password of the user.
  final String? password;

  /// Creates a new instance of `User` with updated values.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  /// Converts a JSON object to an instance of `User`.
  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts an instance of `User` to a JSON object.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      profileImage,
      username,
      password,
    ];
  }
}

/// Extension on [User] class to provide login validation functionality.
extension LoginValidator on User {
  /// Validates if the email and password fields of a user are valid for login.
  ///
  /// Returns a [String] error message if the validation fails, otherwise returns null.
  String? validateLogin() {
    if (email == null || email!.isEmpty) {
      return 'Please enter your email';
    }
    if (password == null || password!.isEmpty) {
      return 'Please enter your password';
    }
    if (!RegExp(r'^[a-zA-Z0-9+._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$')
        .hasMatch(email!)) {
      return 'Invalid email format';
    }
    return null;
  }
}

/// Extension on the User class to validate user signup information.
extension SignupValidator on User {
  /// Validates the user's signup information.
  /// Returns a string error message if any of the information is invalid,
  /// or null if all information is valid.
  String? validateSignup() {
    if (name == null || name!.isEmpty) {
      return 'Please enter your name';
    }
    if (email == null || email!.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[a-zA-Z0-9+._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email!)) {
      return 'Invalid email format';
    }
    if (username == null || username!.isEmpty) {
      return 'Please enter a username';
    }
    if (password == null || password!.isEmpty) {
      return 'Please enter a password';
    }
    if (password!.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}

/// Extension for the `User` class that adds a method to check if a user with
/// the same email already exists in the database.
extension UserExtension on User {
  /// Checks if a user with the same email already exists in the database.
  ///
  /// Returns `true` if the user exists, `false` otherwise.
  Future<User?> getUser(
    UserService userService,
  ) async {
    final user = (await userService.getUsers())
        .firstWhereOrNull((user) => user.email == email);

    return user;
  }
}
