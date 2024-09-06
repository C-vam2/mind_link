import 'package:flutter/material.dart';
import 'package:mind_link/screens/TextPostFullview.dart';
import 'package:share_plus/share_plus.dart';

class TextPostCard extends StatefulWidget {
  final String textData;
  final String description;
  final String date;
  final String username;
  const TextPostCard(
      {super.key,
      required this.textData,
      required this.description,
      required this.date,
      required this.username});

  @override
  State<TextPostCard> createState() => _TextPostCardState();
}

class _TextPostCardState extends State<TextPostCard> {
  _shareLink() {
    Share.share(widget.textData, subject: 'Shared by: ${widget.username}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(8),
              leading: const Icon(
                Icons.account_circle_rounded,
                color: Colors.lightBlueAccent,
                size: 40,
              ),
              title: Text(
                widget.username,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              subtitle: Text(
                widget.date,
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white54),
                onPressed: () {},
              ),
            ),
            GestureDetector(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  child: Text(
                    widget.textData,
                    maxLines: 9,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 0.5,
                        height: 1.5),
                  ),
                ),
              ),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TextPostFullView(
                    username: widget.username,
                    date: widget.date,
                    description: widget.description,
                    textData: widget.textData,
                  ),
                ))
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white60, fontSize: 13),
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
          ],
        ),
      ),
    );
  }
}
