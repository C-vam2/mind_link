import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagePostCard extends StatefulWidget {
  final String imageUrl;
  final String description;
  final String date;
  final String username;

  const ImagePostCard({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.description,
    required this.username,
  });

  @override
  State<ImagePostCard> createState() => _ImagePostCardState();
}

class _ImagePostCardState extends State<ImagePostCard> {
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(NetworkImage(widget.imageUrl), context).then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      print("Error loading image for ${widget.username}: $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _launchUrl() async {
    final _url = Uri.parse(widget.imageUrl);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: isLoading
                    ? Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black12,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.imageUrl,
                          fit: kIsWeb ? BoxFit.contain : BoxFit.cover,
                          width: double.infinity,
                          height: 220,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black12,
                              ),
                              child: const Center(
                                child: Text(
                                  "Unable to load image",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: Row(
                children: [
                  const VerticalDivider(
                    thickness: 3,
                    width: 1,
                    color: Colors.lightBlueAccent,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchUrl().catchError((e) => {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e)))
                          });
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
