import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/auth/domain/entities/user_entity.dart';
import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase;

  SupabaseAuthRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Stream<UserEntity?> authStateChanges() {
    return _supabase.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user == null) return null;

      return UserEntity(id: user.id);
    });
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw 'Login failed: ${e.toString()}';
    }
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await _supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      throw 'Register failed: ${e.toString()}';
    }
  }

  @override
  void logout() => _supabase.auth.signOut();
}
