import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository _authRepository;

  Login({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<void> call(String email, String password) {
    if (email.isEmpty) throw 'Email can\'t be empty';
    if (password.isEmpty) throw 'Password can\'t be empty';
    return _authRepository.login(email, password);
  }
}
