import 'package:auth_data_source/auth_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

/// Creates an instance of the AuthDataSourceImplementation class and assigns it
/// to the private variable _authImplementation.
final _authImplementation = AuthDataSourceImplementation();

/// Creates a provider that returns an instance of AuthDataSource when called.
/// The provider function takes a callback that accepts a single parameter,
/// which is not used here.
/// The callback returns the _authImplementation instance created earlier.
final authProvider = provider<AuthDataSource>((_) => _authImplementation);
