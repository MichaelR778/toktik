import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/usecases/get_profile.dart';
import 'package:toktik/features/profile/domain/usecases/update_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfile _getProfileUsecase;
  final UpdateProfile _updateProfileUsecase;

  ProfileCubit({
    required GetProfile getProfileUsecase,
    required UpdateProfile updateProfileUsecase,
  }) : _getProfileUsecase = getProfileUsecase,
       _updateProfileUsecase = updateProfileUsecase,
       super(ProfileLoading());

  Future<void> loadProfile(String userId) async {
    try {
      emit(ProfileLoading());
      final userProfile = await _getProfileUsecase(userId);
      emit(ProfileLoaded(userProfile: userProfile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile(
    UserProfile oldProfile,
    String newUsername,
    File? newProfileImage,
  ) async {
    await _updateProfileUsecase(oldProfile, newUsername, newProfileImage);
  }
}
