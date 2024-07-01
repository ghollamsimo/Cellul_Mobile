import 'package:flutter/material.dart';
import 'package:flutter_pr/firebase/Chatroom_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "All Messages",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            ChatTile(
              name: 'James Hall',
              message: 'Hey man, what’s up?',
              imagePath: 'assets/avatar1.png',
              isRead: false,
            ),
           
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String imagePath;
  final bool isRead;

  ChatTile({
    required this.name,
    required this.message,
    required this.imagePath,
    required this.isRead,
  });

  @override
   Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatroomScreen()),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: isRead
            ? Icon(Icons.check, color: Colors.black)
            : Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 60, 5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
