import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_clone/data.dart';
import 'package:flutter_youtube_clone/screens/nav_screen.dart';
import 'package:flutter_youtube_clone/widgets/video_card.dart';
import 'package:flutter_youtube_clone/widgets/video_info.dart';
import 'package:miniplayer/miniplayer.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedVideo = ref.watch(selectedVideoProvider);
        final miniplayerController = ref.watch(miniplayerControllerProvider);
        if (selectedVideo == null) {
          return Container();
        }
        return GestureDetector(
            onTap: () {},
            child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: CustomScrollView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                        child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                selectedVideo.thumbnailUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 220,
                              ),
                              Container(
                                color: Colors.black12,
                                child: IconButton(
                                    onPressed: () {
                                      miniplayerController.animateToHeight(
                                          state: PanelState.MIN);
                                    },
                                    icon:
                                        const Icon(Icons.keyboard_arrow_down)),
                              )
                            ],
                          ),
                          const LinearProgressIndicator(
                              value: 0.4, color: Colors.red),
                          VideoInfo(video: selectedVideo)
                        ],
                      ),
                    )),
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return VideoCard(
                        video: suggestedVideos[index],
                        onTap: () => _scrollController?.animateTo(0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn),
                      );
                    }, childCount: suggestedVideos.length))
                  ],
                )));
      },
    );
  }
}
