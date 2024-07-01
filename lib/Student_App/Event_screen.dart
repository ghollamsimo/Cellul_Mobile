import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pr/Services/Events_Service.dart';

class EventScreen extends StatefulWidget {
  final int eventId;
  EventScreen({required this.eventId});
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Map<String, dynamic>? eventData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEvent();
  }

  Future<void> _fetchEvent() async {
    try {
      final data = await EventsService.getEvent(widget.eventId);
      setState(() {
        eventData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
       
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          if (eventData?['media'] != null &&
                              eventData!['media'].isNotEmpty)
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 300,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 2.0,
                                viewportFraction: 1.0,
                              ),
                              items: eventData!['media'].map<Widget>((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Image.network(
                                      item['image_path'],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              }).toList(),
                            )
                          else
                            Image.network(
                              'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              color: Colors.black54,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                eventData?['title'] ?? 'Event Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  eventData?['start_time'] ?? 'Event Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  eventData?['localisation'] ??
                                      'Event Location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Divider(),
                            SizedBox(height: 16),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              eventData?['description'] ?? 'Event Description',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 16),
                            Divider(),
                            SizedBox(height: 16),
                            Text(
                              'Posted By ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/the_happy_co.png'), // Replace with your image asset
                                  radius: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  eventData?['organizer'] ?? 'Mr. Abdellaoui Siad',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
