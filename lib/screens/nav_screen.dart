import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_clone/data.dart';
import 'package:flutter_youtube_clone/screens/home_screen.dart';
import 'package:flutter_youtube_clone/screens/video_screen.dart';
import 'package:miniplayer/miniplayer.dart';

final selectedVideoProvider = StateProvider<Video?>((_) => null);
final miniplayerControllerProvider =
    StateProvider<MiniplayerController>((_) => MiniplayerController());

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static const double _playerMinHeight = 60;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const Scaffold(
      body: Center(child: Text('Search')),
    ),
    const Scaffold(
      body: Center(child: Text('Add')),
    ),
    const Scaffold(
      body: Center(child: Text('Subscriptions')),
    ),
    const Scaffold(
      body: Center(child: Text('Library')),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            showUnselectedLabels: true,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_outlined),
                activeIcon: Icon(Icons.add),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions_outlined),
                activeIcon: Icon(Icons.subscriptions),
                label: 'Subscriptions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                activeIcon: Icon(Icons.library_books),
                label: 'Library',
              ),
            ]),
        body: Consumer(
          builder: ((context, ref, child) {
            final selectedVideo = ref.watch(selectedVideoProvider);
            final miniplayerController =
                ref.watch(miniplayerControllerProvider);
            return Stack(
                children: _screens
                    .asMap()
                    .map((index, screen) => MapEntry(
                        index,
                        Offstage(
                          offstage: index != _currentIndex,
                          child: screen,
                        )))
                    .values
                    .toList()
                  ..add(Offstage(
                    offstage: selectedVideo == null,
                    child: Miniplayer(
                        controller: miniplayerController,
                        minHeight: _playerMinHeight,
                        maxHeight: MediaQuery.of(context).size.height,
                        builder: (height, percentage) {
                          if (selectedVideo == null) {
                            return const SizedBox.shrink();
                          }
                          if (height > _playerMinHeight + 50) {
                            return const VideoScreen();
                          }

                          return Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        selectedVideo.thumbnailUrl,
                                        fit: BoxFit.cover,
                                        height: _playerMinHeight - 4,
                                        width: 120,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                selectedVideo.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 16),
                                              )),
                                              Flexible(
                                                child: Text(
                                                  selectedVideo.author.username,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.play_arrow)),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          ref
                                              .read(selectedVideoProvider
                                                  .notifier)
                                              .state = null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const LinearProgressIndicator(
                                      value: 0.4, color: Colors.red)
                                ],
                              ));
                        }),
                  )));
          }),
        ));
  }
}
