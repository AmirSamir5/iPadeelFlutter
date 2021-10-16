import 'package:flutter/material.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/screens/profile/profile_screen.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class UserSideInfo extends StatefulWidget {
  final User user;
  const UserSideInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<UserSideInfo> createState() => _UserSideInfoState();
}

class _UserSideInfoState extends State<UserSideInfo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProfileScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 64, 0, 32),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: OptimizedCacheImage(
                fit: BoxFit.cover,
                imageUrl: Urls.domain +
                    (widget.user.photo ??
                        "https://images.unsplash.com/photo-1499510318569-1a3d67dc3976?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=928&q=80"),
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black.withOpacity(0.2)),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/user-profile.png'),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.user.firstName ?? ""} ${widget.user.lastName ?? ""}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.user.email ?? "",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 32),
            const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
