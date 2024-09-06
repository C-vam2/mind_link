import 'package:flutter/material.dart';
import 'package:mind_link/data/textPostData.dart';
import 'package:mind_link/widgets/textPostCard.dart';

class TextPostScreen extends StatefulWidget {
  const TextPostScreen({super.key});

  @override
  State<TextPostScreen> createState() => _TextPostScreenState();
}

class _TextPostScreenState extends State<TextPostScreen> {
  final data = textPostData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var currData = data[index];
                return TextPostCard(
                    textData: currData['textData']!,
                    description: currData['description']!,
                    date: currData['date']!,
                    username: currData['userName']!);
              })),
    );
  }
}
