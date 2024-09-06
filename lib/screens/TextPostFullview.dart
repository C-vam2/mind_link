import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TextPostFullView extends StatelessWidget {
  final String username;
  final String textData;
  final String date;
  final String description;
  const TextPostFullView(
      {super.key,
      required this.username,
      required this.textData,
      required this.date,
      required this.description});

  _shareLink() {
    Share.share(textData, subject: 'Shared by: $username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          username,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
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
                  username,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                subtitle: Text(
                  date,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    textData,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.6,
                        letterSpacing: 0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
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
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
