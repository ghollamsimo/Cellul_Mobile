import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_pr/Services/Auth_Service.dart';
import 'package:flutter_pr/Services/Calendar_Service.dart';
import '../api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentPage extends StatefulWidget {
  final int adviserId;

  AppointmentPage({required int this.adviserId});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  List<String> times = [];
  bool isBooked = false;
  List<Map<String, dynamic>> availability = [];

  @override
  void initState() {
    super.initState();
    fetchCalendarData();
  }

  Future<void> fetchCalendarData() async {
    try {
      final fetchedAvailability = await CalendarService.getCalendar(widget.adviserId);
      setState(() {
        availability = fetchedAvailability;
        updateTimesForSelectedDate();
      });
    } catch (error) {
      print('Error fetching calendar: $error');
    }
  }

  void updateTimesForSelectedDate() {
    final dateKey = selectedDate.toIso8601String().split('T')[0];
    List<String> newTimes = [];

    for (var calendar in availability) {
      if (calendar['availability'].containsKey(dateKey)) {
        newTimes.addAll(calendar['availability'][dateKey].cast<String>());
      }
    }

    newTimes.sort();

    setState(() {
      times = newTimes;
      selectedTime = times.isNotEmpty ? times[0] : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    print('adviserId: ${widget.adviserId}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildHorizontalCalendar(),
          SizedBox(height: 20),
          _buildTimeSlots(),
          SizedBox(height: 20),
          _buildBookButton(),
        ],
      ),
    );
  }

  Widget _buildHorizontalCalendar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 365)),
        focusedDay: selectedDate,
        calendarFormat: CalendarFormat.week,
        availableCalendarFormats: const {CalendarFormat.week: 'Week'},
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            selectedDate = selectedDay;
            updateTimesForSelectedDate();
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

   Widget _buildTimeSlots() {
    return Expanded(
      child: times.isNotEmpty
          ? GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: times.length,
              itemBuilder: (context, index) {
                return Card(
                  color:
                      selectedTime == times[index] ? Colors.blue : Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = times[index];
                      });
                    },
                    child: Center(
                      child: Text(
                        times[index],
                        style: TextStyle(
                          color: selectedTime == times[index]
                              ? Colors.white
                              : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No time available',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
    );
  }

  Widget _buildBookButton() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showConfirmationDialog();
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Container(
            constraints:
                BoxConstraints(minHeight: 50), // Adjust height as needed
            alignment: Alignment.center,
            child: Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }


  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Appointment'),
          content: Text(
              'Are you sure you want to book this appointment on ${selectedDate.year}-${selectedDate.month}-${selectedDate.day} at $selectedTime?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                bookAppointment(
                    selectedDate, selectedTime); // Proceed with booking
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void bookAppointment(DateTime selectedDate, String selectedTime) {


    AppointmentsService.addAppointment(
           selectedDate,  widget.adviserId, selectedTime)
        .then((response) {
      setState(() {
        isBooked = true;
      });
      _showSuccessDialog();
    }).catchError((error) {
      print('Error: $error');
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your appointment has been successfully booked. Please wait for confirmation from the adviser.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class AppointmentsService {
  static Future<Map<String, dynamic>> addAppointment(
      DateTime selectedDate, int id, String selectedTime) async {
    final url = Uri.parse('${baseUrl}appointment/add_appointment/$id');
    final token = await AuthService.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = json.encode(
        {'date': selectedDate.toString(), 'time': selectedTime.toString()});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to add appointment');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server. Please check your internet connection.');
    }
  }
}
