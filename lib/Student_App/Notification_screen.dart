import 'package:flutter/material.dart';
import 'package:flutter_pr/Services/Notification_Service.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<dynamic>> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = NotificationService.getNotifications();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _NoNotificationFound();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!.map<Widget>((notification) {
                        bool isEvent = notification['event'] != null;
                        String message = notification['message'];
                        String createdAt = notification['created_at'];

                        return NotificationCard(
                          message: message,
                          time: createdAt,
                          isEvent: isEvent, onDismissed: () {  },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }


}


Widget _NoNotificationFound() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/notification.png',
          height: 200,
        ),
        SizedBox(height: 20),
        Text(
          'No Notification Found',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Your notifications will appear here once you\'ve received them',
            style: GoogleFonts.poppins(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class NotificationCard extends StatelessWidget {
  final String message;
  final String time;
  final bool isEvent;
  final VoidCallback onDismissed;

  NotificationCard({
    required this.message,
    required this.time,
    required this.isEvent,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), 
      direction: DismissDirection.endToStart, 
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        onDismissed();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        color: Colors.grey[70],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 30,
                child: Icon(
                  isEvent ? Icons.event : Icons.book_online,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEvent
                          ? 'Event Notification'
                          : 'Appointment Notification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      message, // Actual message
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      time, // Actual time
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
