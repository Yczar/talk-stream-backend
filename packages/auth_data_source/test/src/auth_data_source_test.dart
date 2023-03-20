// ignore_for_file: prefer_const_constructors
import 'package:auth_data_source/src/implementation/auth_data_source_implementation.dart';
import 'package:test/test.dart';

void main() {
  group('AuthDataSource', () {
    test('can be instantiated', () {
      expect(AuthDataSourceImplementation(), isNotNull);
    });
  });
}
