import 'package:auth_data_source/auth_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

final _authImplementation = AuthDataSourceImplementation();
final authProvider = provider<AuthDataSource>((_) => _authImplementation);
