import 'models/user.dart';

/// An interface for an authentication data source.
/// An authentication data source supports user sign-in, sign-up, and user retrieval operations.
abstract class AuthDataSource {
  /// Sign in the user and return the authenticated user.
  Future<User> signIn(User user);

  /// Sign up the user and return the newly registered user.
  Future<User> signUp(User user);

  /// Return all the registered users.
  Future<List<User>> getUsers(String userId);
}
///  The AuthDataSource class is an interface for an authentication data source 
/// that provides basic user authentication and user retrieval operations. 
/// The class includes three asynchronous functions, which are signIn, signUp, 
/// and getUsers. The signIn function authenticates the user and returns the 
/// authenticated user object. The signUp function registers a new user and 
/// returns the newly created user object. The getUsers function returns a 
/// list of all registered users. All functions in the AuthDataSource class 
/// return a Future, indicating that the operation is asynchronous and will be 
/// completed at some point in the future. This class can be extended by 
/// concrete authentication data source implementations to provide 
/// actual implementation details.