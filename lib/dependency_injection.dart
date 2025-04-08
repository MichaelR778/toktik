import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:toktik/features/auth/domain/repositories/auth_repository.dart';
import 'package:toktik/features/auth/domain/usecases/get_auth_state_changes.dart';
import 'package:toktik/features/auth/domain/usecases/get_current_user.dart';
import 'package:toktik/features/auth/domain/usecases/login.dart';
import 'package:toktik/features/auth/domain/usecases/logout.dart';
import 'package:toktik/features/auth/domain/usecases/register.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/feed/presentation/cubits/feed_cubit.dart';
import 'package:toktik/features/follow/data/repositories/supabase_follow_repository.dart';
import 'package:toktik/features/follow/domain/repositories/follow_repository.dart';
import 'package:toktik/features/follow/domain/usecases/follow.dart';
import 'package:toktik/features/follow/domain/usecases/unfollow.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_cubit.dart';
import 'package:toktik/features/like/data/repositories/supabase_like_repositories.dart';
import 'package:toktik/features/like/domain/repositories/like_repository.dart';
import 'package:toktik/features/like/domain/usecases/is_liked.dart';
import 'package:toktik/features/like/domain/usecases/toggle_like.dart';
import 'package:toktik/features/like/presentation/cubits/like_cubit.dart';
import 'package:toktik/features/post/data/repositories/supabase_post_repository.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';
import 'package:toktik/features/post/domain/usecases/create_post.dart';
import 'package:toktik/features/post/domain/usecases/fetch_posts.dart';
import 'package:toktik/features/post/domain/usecases/fetch_user_posts.dart';
import 'package:toktik/features/post/presentation/cubits/post_cubit.dart';
import 'package:toktik/features/profile/data/repositories/supabase_profile_repository.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';
import 'package:toktik/features/profile/domain/usecases/get_profile.dart';
import 'package:toktik/features/profile/domain/usecases/update_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_posts_cubit.dart';
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
  getIt.registerLazySingleton(
    () => PostCubit(createPostUsecase: getIt(), getCurrentUserUsecase: getIt()),
  );
  getIt.registerLazySingleton(() => FeedCubit(fetchPostsUsecase: getIt()));
  getIt.registerLazySingleton(
    () => LikeCubit(
      toggleLikeUsecase: getIt(),
      isLikedUsecase: getIt(),
      getCurrentuserUsecase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => ProfilePostsCubit(fetchUserPostsUsecase: getIt()),
  );
  getIt.registerLazySingleton(
    () => FollowCubit(
      followUsecase: getIt(),
      unfollowUsecase: getIt(),
      getCurrentUserUsecase: getIt(),
    ),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetAuthStateChanges(authRepository: getIt()),
  );
  getIt.registerLazySingleton(() => Login(authRepository: getIt()));
  getIt.registerLazySingleton(() => Register(authRepository: getIt()));
  getIt.registerLazySingleton(() => Logout(authRepository: getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(authRepository: getIt()));
  getIt.registerLazySingleton(
    () => GetProfile(profileRepository: getIt(), followRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => UpdateProfile(profileRepository: getIt(), storageRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => CreatePost(postRepository: getIt(), storageRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchPosts(
      postRepository: getIt(),
      likeRepository: getIt(),
      profileRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => FetchUserPosts(
      postRepository: getIt(),
      likeRepository: getIt(),
      profileRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => ToggleLike(likeRepository: getIt()));
  getIt.registerLazySingleton(() => IsLiked(likeRepository: getIt()));
  getIt.registerLazySingleton(() => Follow(followRepository: getIt()));
  getIt.registerLazySingleton(() => Unfollow(followRepository: getIt()));

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
  getIt.registerLazySingleton<PostRepository>(
    () => SupabasePostRepository(supabase: getIt()),
  );
  getIt.registerLazySingleton<LikeRepository>(
    () => SupabaseLikeRepositories(supabase: getIt()),
  );
  getIt.registerLazySingleton<FollowRepository>(
    () => SupabaseFollowRepository(supabase: getIt()),
  );

  // external package etc
  getIt.registerLazySingleton(() => Supabase.instance.client);
}
