import 'package:auth_data_source/auth_data_source.dart';
import 'package:uuid/uuid.dart';

/// An implementation of the [AuthDataSource] that uses a [UserService] to handle
/// authentication-related operations.
class AuthDataSourceImplementation extends AuthDataSource {
  /// Creates a new instance of the [AuthDataSourceImplementation].
  ///
  /// The [databaseFileName] parameter is used to specify the name of the database
  /// file to use for storing user data.
  AuthDataSourceImplementation({
    this.databaseFileName = 'users.json',
  }) : userService = UserService(databaseFileName);

  /// The name of the database file to use for storing user data.
  final String databaseFileName;

  /// The [UserService] instance to use for handling user-related operations.
  final UserService userService;

  @override
  Future<List<User>> getUsers(String userId) async {
    return await userService.getUsers(userId);
  }

  @override
  Future<User> signIn(User user) async {
    try {
      final String? validator = user.validateLogin();
      final isValidated = validator == null;
      if (isValidated) {
        final dbUser = await user.getUser(userService);
        if (dbUser == null) {
          throw SignInException('user does not exist');
        } else {
          return dbUser;
        }
      } else {
        throw SignInException(validator);
      }
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<User> signUp(User user) async {
    try {
      final String? validator = user.validateSignup();
      final isValidated = validator == null;
      if (isValidated) {
        final dbUser = await user.getUser(userService);
        if (dbUser != null) {
          throw SignUpException('user with ${dbUser.email} already exists');
        }
        final usr = user.copyWith(
          id: Uuid().v4(),
        );

        await userService.addUser(usr);
        return usr;
      } else {
        throw SignUpException(validator);
      }
    } catch (e, s) {
      print(s);
      throw AuthException(e.toString());
    }
  }
}
