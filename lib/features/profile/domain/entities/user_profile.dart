class UserProfile {
  final String userId;
  final String username;
  final String profileImageUrl;
  final List<String> followers;
  final List<String> following;

  UserProfile({
    required this.userId,
    required this.username,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });
}
