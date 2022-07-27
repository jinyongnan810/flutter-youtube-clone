import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_youtube_clone/data.dart';
import 'package:flutter_youtube_clone/screens/nav_screen.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoCard extends ConsumerWidget {
  final Video video;
  final VoidCallback? onTap;
  const VideoCard({Key? key, required this.video, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ref.read(selectedVideoProvider.notifier).state = video;
            final miniPlayer =
                ref.read(miniplayerControllerProvider.notifier).state;
            miniPlayer.animateToHeight(state: PanelState.MAX);
            onTap?.call();
          },
          child: Stack(children: [
            Image.network(
              video.thumbnailUrl,
              fit: BoxFit.cover,
              height: 220,
              width: double.infinity,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black54,
                child: Text(
                  video.duration,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => print('Move to profile'),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(video.author.profileImageUrl),
                  )),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16),
                    )),
                    Flexible(
                      child: Text(
                        '${video.author.username} · ${video.viewCount} views · ${timeago.format(video.timestamp)}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: const Icon(Icons.more_vert),
                onTap: () => print('move to more'),
              )
            ],
          ),
        )
      ],
    );
  }
}
