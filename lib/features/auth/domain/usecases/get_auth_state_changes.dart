import 'package:toktik/features/auth/domain/entities/user_entity.dart';
import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateChanges {
  final AuthRepository _authRepository;

  GetAuthStateChanges({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Stream<UserEntity?> call() => _authRepository.authStateChanges();
}
