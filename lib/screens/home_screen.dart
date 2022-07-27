import 'package:flutter/material.dart';
import 'package:flutter_youtube_clone/data.dart';
import 'package:flutter_youtube_clone/widgets/custom_sliver_app_bar.dart';
import 'package:flutter_youtube_clone/widgets/video_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const CustomSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 60),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
            return VideoCard(video: videos[index]);
          }, childCount: videos.length)),
        ),
      ],
    ));
  }
}
