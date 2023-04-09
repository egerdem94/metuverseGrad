import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: 10, // replace this with the number of comments you have
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/50'), // Replace this with the user's profile picture
            ),
            title: Text(
              'User Name', // Replace this with the user's name
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'This is a comment', // Replace this with the comment's text
              style: TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Submit the comment
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
