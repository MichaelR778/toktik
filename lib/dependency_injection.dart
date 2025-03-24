import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';
import 'package:toktik/features/auth/domain/usecases/get_auth_state_changes.dart';
import 'package:toktik/features/auth/domain/usecases/login.dart';
import 'package:toktik/features/auth/domain/usecases/logout.dart';
import 'package:toktik/features/auth/domain/usecases/register.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/profile/data/repositories/supabase_profile_repository.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';
import 'package:toktik/features/profile/domain/usecases/get_profile.dart';
import 'package:toktik/features/profile/domain/usecases/update_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/storage/data/repositories/supabase_storage_repository.dart';
import 'package:toktik/features/storage/domain/repositories/storage_repository.dart';

final getIt = GetIt.instance;

void initDependencies() {
  // cubit
  getIt.registerLazySingleton(
    () => AuthCubit(
      getAuthStateChanges: getIt(),
      loginUsecase: getIt(),
      registerUsecase: getIt(),
      logoutUsecase: getIt(),
    ),
  );
  getIt.registerFactory(
    () =>
        ProfileCubit(getProfileUsecase: getIt(), updateProfileUsecase: getIt()),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetAuthStateChanges(authRepository: getIt()),
  );
  getIt.registerLazySingleton(() => Login(authRepository: getIt()));
  getIt.registerLazySingleton(() => Register(authRepository: getIt()));
  getIt.registerLazySingleton(() => Logout(authRepository: getIt()));
  getIt.registerLazySingleton(() => GetProfile(profileRepository: getIt()));
  getIt.registerLazySingleton(
    () => UpdateProfile(profileRepository: getIt(), storageRepository: getIt()),
  );

  // repository
  getIt.registerLazySingleton<AuthRepository>(
    () => SupabaseAuthRepository(supabase: getIt()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => SupabaseProfileRepository(supabase: getIt()),
  );
  getIt.registerLazySingleton<StorageRepository>(
    () => SupabaseStorageRepository(supabase: getIt()),
  );

  // external package etc
  getIt.registerLazySingleton(() => Supabase.instance.client);
}
