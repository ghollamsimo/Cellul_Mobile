import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<ChatroomScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'message':
          'Hello',
      'time': '9:25 AM',
      'isMe': 'false',
    },
    {
      'message': 'Hey',
      'time': '9:26 AM',
      'isMe': 'true',
    },
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    setState(() {
      _messages.add({
        'message': _controller.text,
        'time': 'now',
        'isMe': 'true',
      });
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(170, 206, 206, 206),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Robert Brown',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Color.fromARGB(255, 149, 60, 5),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/background_chat.png', 
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final messageData = _messages[index];
                    return ChatBubble(
                      isMe: messageData['isMe'] == 'true',
                      message: messageData['message']!,
                      time: messageData['time']!,
                      attachment: messageData['attachment'],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type here',
                          hintStyle: TextStyle(color: Colors.grey[700]),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 149, 60, 5),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;
  final String? attachment;

  ChatBubble({
    required this.isMe,
    required this.message,
    required this.time,
    this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Color.fromARGB(255, 149, 60, 5) : Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            if (attachment != null)
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  attachment!,
                  style: TextStyle(color: Color.fromARGB(255, 149, 60, 5),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
