import 'package:toktik/features/profile/domain/entities/user_profile.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;

  ProfileLoaded({required this.userProfile});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
