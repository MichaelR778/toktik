import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/usecases/get_auth_state_changes.dart';
import 'package:toktik/features/auth/domain/usecases/login.dart';
import 'package:toktik/features/auth/domain/usecases/logout.dart';
import 'package:toktik/features/auth/domain/usecases/register.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetAuthStateChanges _getAuthStateChanges;
  final Login _loginUsecase;
  final Register _registerUsecase;
  final Logout _logoutUsecase;

  StreamSubscription? _authStateSubscription;

  AuthCubit({
    required GetAuthStateChanges getAuthStateChanges,
    required Login loginUsecase,
    required Register registerUsecase,
    required Logout logoutUsecase,
  }) : _getAuthStateChanges = getAuthStateChanges,
       _loginUsecase = loginUsecase,
       _registerUsecase = registerUsecase,
       _logoutUsecase = logoutUsecase,
       super(Unauthenticated());

  void checkAuthState() {
    _authStateSubscription?.cancel();
    _authStateSubscription = _getAuthStateChanges().listen((user) {
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _loginUsecase(email, password);
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      emit(AuthLoading());
      await _registerUsecase(email, password, confirmPassword);
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void logout() {
    // emit(Unauthenticated());
    _logoutUsecase();
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
