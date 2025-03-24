import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({required super.username, required super.profileImageUrl});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      username: json['username'],
      profileImageUrl: json['pfp_url'],
    );
  }
}
