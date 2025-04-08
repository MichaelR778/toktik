import 'package:toktik/features/auth/domain/entities/user_entity.dart';
import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository _authRepository;

  GetCurrentUser({required AuthRepository authRepository})
    : _authRepository = authRepository;

  UserEntity call() => _authRepository.getCurrUser();
}
