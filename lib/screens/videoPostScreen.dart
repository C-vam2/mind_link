import 'package:flutter/material.dart';
import 'package:mind_link/widgets/videoPostCard.dart';

import '../data/videoPostData.dart';

class VideoPostScreen extends StatefulWidget {
  const VideoPostScreen({super.key});

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

class _VideoPostScreenState extends State<VideoPostScreen> {
  final data = videoData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: ListView(
          children: [
            VideoPostCard(
                key: UniqueKey(),
                videoLink: data[0]['videoLink']!,
                date: data[0]['date']!,
                description: data[0]['description']!,
                username: data[0]['userName']!),
            VideoPostCard(
                key: UniqueKey(),
                videoLink: data[1]['videoLink']!,
                date: data[1]['date']!,
                description: data[1]['description']!,
                username: data[1]['userName']!),
            VideoPostCard(
                key: UniqueKey(),
                videoLink: data[2]['videoLink']!,
                date: data[2]['date']!,
                description: data[2]['description']!,
                username: data[2]['userName']!),
            VideoPostCard(
                key: UniqueKey(),
                videoLink: data[3]['videoLink']!,
                date: data[3]['date']!,
                description: data[3]['description']!,
                username: data[3]['userName']!),
          ],
        ),
      ),
    );
  }
}
