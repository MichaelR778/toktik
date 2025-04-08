import 'package:toktik/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password, String username);
  void logout();
  UserEntity getCurrUser();
}
