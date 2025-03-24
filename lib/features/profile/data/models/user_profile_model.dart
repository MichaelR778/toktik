import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.userId,
    required super.username,
    required super.profileImageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['id'],
      username: json['username'],
      profileImageUrl: json['pfp_url'],
    );
  }
}
