// ignore_for_file: prefer_const_constructors
import 'package:auth_data_source/auth_data_source.dart';
import 'package:chat_data_source/chat_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('ChatDataSource', () {
    test('can be instantiated', () {
      expect(
          ChatDatasourceImplementation(
              userService: UserService(
            '',
          )),
          isNotNull);
    });
  });
}
