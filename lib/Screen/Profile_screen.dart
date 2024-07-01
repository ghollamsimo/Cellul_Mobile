import 'package:flutter/material.dart';
import 'package:flutter_pr/Screen/Profile_screen.dart';
import 'package:flutter_pr/Services/Auth_Service.dart';
import 'package:flutter_pr/Student_App/Home_screen.dart';

class ProfilePage extends StatefulWidget {
  final int? userDetails;

  ProfilePage({required this.userDetails});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = AuthService.getUser(widget.userDetails);
  }


  void _showChangePasswordModal(BuildContext context) {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
             

              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                   onPressed: () {
                    if (newPasswordController.text ==
                        confirmPasswordController.text) {
                      print('Passwords match! Proceed with password change.');

                      bool passwordChangeSuccess = false;

                      if (!passwordChangeSuccess) {
                        _showErrorDialog(context,
                            'Password change failed. Please try again.');
                      }
                    } else {
                      _showErrorDialog(
                          context, 'Passwords do not match. Please try again.');
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 0, 28, 240),
                          Color.fromARGB(255, 96, 64, 255)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: 50), // Adjust height as needed
                      alignment: Alignment.center,
                      child: Text(
                        'Submit',
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
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final user = snapshot.data!['user'];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/user.png'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user['email'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Handle edit profile
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                   
                                        _buildListTile(Icons.lock, 'Change password', context,
                        () => _showChangePasswordModal(context)),


                    SizedBox(height: 20),
                    _buildListTile(
                        Icons.help_outline, 'Need help? Let\'s chat', context),
                    _buildListTile(
                        Icons.security, 'Lender Protection Guarantee', context),
                    _buildListTile(
                        Icons.privacy_tip, 'Privacy Policy', context),
                    SizedBox(height: 130),
                    _buildListTile(
                        Icons.logout, 'Log Out', context, 
                        ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );

    
  }

 Widget _buildListTile(IconData icon, String title, BuildContext context, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap ?? () {
        // Handle tap
      },
    );
  }

}
