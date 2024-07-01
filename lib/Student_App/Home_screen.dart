import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pr/Auth/welcome_screen.dart';
import 'package:flutter_pr/Screen/Testt.dart';
import 'package:flutter_pr/Screen/profile_screen.dart';
import 'package:flutter_pr/Services/Advisers_Service.dart';
import 'package:flutter_pr/Services/Appointments_Service.dart';
import 'package:flutter_pr/Services/Events_Service.dart';
import 'package:flutter_pr/Student_App/Advise_screen.dart';
import 'package:flutter_pr/Student_App/Event_screen.dart';
import 'package:flutter_pr/Student_App/Notification_screen.dart';
import 'package:flutter_pr/firebase/Chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final int? userId;
  HomePage({required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final List<Widget> _pages = [WelcomeScreen()];

  Map<String, dynamic>? appointmentData;

  @override
  void initState() {
    super.initState();
    fetchAppointmentData();
  }

  Future<void> fetchAppointmentData() async {
    try {
      Map<String, dynamic> data = await AppointmentsService.getAppointment();
      setState(() {
        appointmentData = data;
      });
    } catch (e) {
      print('Error fetching appointment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text('Cellule Ecoute', style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            _buildSearchBar(),
            SizedBox(height: 8),
            appointmentData != null ? _buildUpcomingScheduleCard() : SizedBox(),
            SizedBox(height: 16),
            _buildSectionTitle('Most Events'),
            SizedBox(height: 5),
            FutureBuilder(
              future: EventsService.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return Text('No events available');
                } else {
                  List events = snapshot.data as List;
                  return _buildEventsCard(events);
                }
              },
            ),
            SizedBox(height: 18),
            _buildSectionTitle('Most Advisers'),
            SizedBox(height: 8),
            FutureBuilder(
              future: AdvisersService.getAdvisers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return Text('No advisers available');
                } else {
                  List advisers = snapshot.data as List;
                  return _AdvisersCards(advisers);
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: _BottomBar(userId: widget.userId),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 149, 60, 5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingScheduleCard() {
    if (appointmentData == null) return SizedBox();

    var student = appointmentData!['student'];
    var advise = appointmentData!['advise'];
    var date = DateTime.parse(appointmentData!['date']);
    var formattedDate = '${date.day}, ${date.month} ${date.year}';
    var timeString = appointmentData!['time'].toString();

    return Dismissible(
      key: Key(appointmentData!['id'].toString()),
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
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Appointment dismissed',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
            ),
          );
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Color.fromARGB(255, 201, 129, 36),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/41115140?v=4',
                ),
                radius: 30,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    advise['user']['name'],
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.access_time, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '$timeString:00 - ${(int.parse(timeString) + 1).toString()}:00',
                        style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }

  Widget _buildEventsCard(List events) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300, // Adjust height as needed
        autoPlay: false,
        enlargeCenterPage: true,
      ),
      items: events.map((event) {
        String imageUrl = event['media'].isNotEmpty
            ? event['media'][0]['image_path']
            : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';

        String description = event['description'] ??
            'The Description Is Not Must Be Implemented';
        if (description.length > 50) {
          description = description.substring(0, 50) + '...';
        }

        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'] ?? 'Event Title',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventScreen(eventId: event['id']),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Learn more',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _AdvisersCards(List advisers) {
    return Container(
      height: 300,
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: advisers.length,
        itemBuilder: (context, index) {
          final adviser = advisers[index];
          String imageUrl = adviser['user']['image'] ?? 'assets/profile.jpg';
          String name = adviser['user']['name'];
          String specialty = adviser['user']['role'] ?? 'role';

          return FutureBuilder(
            future: AdvisersService.count_Appointment(adviser['id']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                int appointmentCount = snapshot.data as int;
                String distance = 'Number of Appointments: $appointmentCount';

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        name,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            specialty,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.timer_sharp,
                                  color: Colors.grey, size: 16),
                              SizedBox(width: 5),
                              Text(
                                distance,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AdvisePage(adviserId: adviser['id']),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Container(); // Return an empty container if no data is present
              }
            },
          );
        },
      ),
    );
  }
  Widget _BottomBar({required int? userId}) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Color.fromARGB(255, 149, 60, 5),
      color: Color.fromARGB(255, 149, 60, 5),
      animationDuration: const Duration(milliseconds: 300),
      items: const <Widget>[
        Icon(Icons.home, size: 26, color: Colors.white),
        Icon(Icons.message, size: 26, color: Colors.white),
        Icon(Icons.add, size: 26, color: Colors.white),
        Icon(Icons.notifications, size: 26, color: Colors.white),
        Icon(Icons.person, size: 26, color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          if (index == 4 && userId == null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          } else if (index == 4 && userId == userId) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        userDetails: userId,
                      )),
            );
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(userId: userId)),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          } else {
            _page = index;
          }
        });
      },
    );
  }
}
