import 'package:EnergyControl/models/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SharedPreferences tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('saveUserId saves the userId', () async {
      const testUserId = '12345';
      await saveUserId(testUserId);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final savedUserId = prefs.getString('userId');
      expect(savedUserId, testUserId);
    });

    test('getUserId retrieves the saved userId', () async {
      const testUserId = '12345';
      await saveUserId(testUserId);

      final retrievedUserId = await getUserId();
      expect(retrievedUserId, testUserId);
    });

    test('deleteUserId removes the userId', () async {
      const testUserId = '12345';
      await saveUserId(testUserId);
      await deleteUserId();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final deletedUserId = prefs.getString('userId');
      expect(deletedUserId, isNull);
    });

    test('userIdExists returns true if userId exists', () async {
      const testUserId = '12345';
      await saveUserId(testUserId);

      final exists = await userIdExists();
      expect(exists, isTrue);
    });

    test('userIdExists returns false if userId does not exist', () async {
      await deleteUserId();

      final exists = await userIdExists();
      expect(exists, isFalse);
    });
  });
}