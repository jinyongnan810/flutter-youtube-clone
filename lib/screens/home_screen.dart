import 'package:flutter/material.dart';
import 'package:flutter_youtube_clone/widgets/custom_sliver_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CustomScrollView(
      slivers: [CustomSliverAppBar()],
    ));
  }
}
