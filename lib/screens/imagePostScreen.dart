import 'package:flutter/material.dart';
import 'package:mind_link/data/imagePostData.dart';
import 'package:mind_link/widgets/imagePostCard.dart';

class ImagePostScreen extends StatelessWidget {
  const ImagePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = imagePosts;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var currData = data[index];
            return Expanded(
              child: ImagePostCard(
                  imageUrl: currData['imageUrl']!,
                  date: currData['date']!,
                  description: currData['description']!,
                  username: currData['username']!),
            );
          }),
    );
  }
}
