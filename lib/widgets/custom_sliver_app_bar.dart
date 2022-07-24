import 'package:flutter/material.dart';
import 'package:flutter_youtube_clone/data.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Image.asset('assets/yt_logo_dark.png'),
      ),
      leadingWidth: 100,
      actions: [
        IconButton(
          icon: const Icon(Icons.cast),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: CircleAvatar(
              foregroundImage: NetworkImage(currentUser.profileImageUrl),
            ))
      ],
    );
  }
}
