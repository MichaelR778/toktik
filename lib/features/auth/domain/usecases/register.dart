import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository _authRepository;

  Register({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<void> call(String email, String password, String confirmPassword) {
    if (email.isEmpty) throw 'Email can\'t be empty';
    if (password.isEmpty) throw 'Password can\'t be empty';
    if (confirmPassword.isEmpty) throw 'Confirm password can\'t be empty';
    if (password != confirmPassword) throw 'Password does not match';
    return _authRepository.register(email, password);
  }
}
