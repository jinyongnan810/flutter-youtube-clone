import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_youtube_clone/data.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoInfo extends StatelessWidget {
  final Video video;
  const VideoInfo({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            video.title,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 8),
          Text('${video.viewCount} views · ${timeago.format(video.timestamp)}'),
          const Divider(),
          _ActionsRow(video: video),
          const Divider(),
          _AuthorRow(user: video.author)
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  final Video video;
  const _ActionsRow({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildAction(context, Icons.thumb_up_outlined, video.likes),
        _buildAction(context, Icons.thumb_down_outlined, video.dislikes),
        _buildAction(context, Icons.reply_outlined, 'Share'),
        _buildAction(context, Icons.download_outlined, 'Download'),
        _buildAction(context, Icons.library_add_outlined, 'Save'),
      ],
    );
  }

  _buildAction(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _AuthorRow extends StatelessWidget {
  final User user;
  const _AuthorRow({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Move to profile'),
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(user.profileImageUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Text(
                  user.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                )),
                Flexible(
                  child: Text(
                    '${user.subscribers} Subscribers',
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
          TextButton(
              onPressed: () {},
              child: Text(
                'Subscribe',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.red),
              )),
        ],
      ),
    );
  }
}
