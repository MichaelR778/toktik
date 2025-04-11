import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class Chat {
  final String id;
  final DateTime lastUpdated;
  final UserProfile otherUserProfile;

  Chat({
    required this.id,
    required this.lastUpdated,
    required this.otherUserProfile,
  });
}
