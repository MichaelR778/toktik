import 'package:flutter/material.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class UserTile extends StatelessWidget {
  final UserProfile profile;
  final Widget navigateTo;
  final Widget? trailing;

  const UserTile({
    super.key,
    required this.profile,
    required this.navigateTo,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: ProfileImage(imageUrl: profile.profileImageUrl, diameter: 50),
      title: Text(profile.username),
      trailing: trailing,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
    );
  }
}
