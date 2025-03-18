import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository})
    : _authRepository = authRepository;

  void call() => _authRepository.logout();
}
