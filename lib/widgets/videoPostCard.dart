import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoPostCard extends StatefulWidget {
  final String videoLink;
  final String description;
  final String date;
  final String username;
  const VideoPostCard(
      {super.key,
      required this.videoLink,
      required this.date,
      required this.description,
      required this.username});

  @override
  State<VideoPostCard> createState() => _VideoPostCardState();
}

class _VideoPostCardState extends State<VideoPostCard> {
  late VideoPlayerController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoLink))
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
        });
      }).onError((error, stackTrace) {
        print("Error ${widget.username}: $error");
        setState(() {
          isLoading = false;
        });
      });
  }

  _shareLink() async {
    final _url = Uri.parse(widget.videoLink);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kIsWeb ? EdgeInsets.all(50) : null,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey[850],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: const Icon(
                Icons.account_circle_rounded,
                color: Colors.lightBlueAccent,
                size: 40,
              ),
              title: Text(
                widget.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                widget.date,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            GestureDetector(
              child: Center(
                child: _controller.value.isInitialized
                    ? Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: VideoPlayer(_controller),
                            ),
                          ),
                          Positioned.fill(
                            child: _controller.value.isPlaying ||
                                    _controller.value.isCompleted
                                ? Icon(
                                    Icons.pause,
                                    size: kIsWeb ? 100 : 50,
                                    color: Colors.lightBlueAccent,
                                  )
                                : Icon(
                                    Icons.play_arrow_rounded,
                                    size: kIsWeb ? 100 : 50,
                                    color: Colors.lightBlueAccent,
                                  ),
                          ),
                        ],
                      )
                    : Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black12,
                        ),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.lightBlueAccent,
                                )
                              : Text(
                                  "Unable to load video",
                                  style: TextStyle(color: Colors.white70),
                                ),
                        ),
                      ),
              ),
              onTap: () => setState(() {
                print("Tapped");
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: Row(
                children: [
                  VerticalDivider(
                    thickness: 3,
                    width: 1,
                    color: Colors.lightBlueAccent,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _shareLink,
                    icon: Icon(
                      Icons.share,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
