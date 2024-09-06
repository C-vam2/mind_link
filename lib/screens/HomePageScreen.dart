import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mind_link/screens/imagePostScreen.dart';
import 'package:mind_link/screens/textPostScreen.dart';
import 'package:mind_link/screens/videoPostScreen.dart';

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key});

  @override
  State<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends State<Homepagescreen> {
  int currIdx = 0;

  List<BottomNavigationBarItem> itemList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.text_snippet_rounded),
      label: "Text",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.play_circle_fill_rounded),
      label: "Videos",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.image_rounded),
      label: "Image",
    ),
  ];

  List<Widget> screens = [
    TextPostScreen(),
    VideoPostScreen(),
    ImagePostScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            'assets/images/media-link-seeklogo.svg',
            height: 30,
            width: 40,
            color: Colors.white,
          ),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currIdx,
        items: itemList,
        backgroundColor: Colors.black54,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currIdx = value;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: screens[currIdx],
      ),
    );
  }
}
