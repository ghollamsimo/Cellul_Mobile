import 'package:flutter/material.dart';
import 'package:flutter_pr/Auth/login_screen.dart';
import 'package:flutter_pr/Auth/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Replace with your image asset or network image
              Image.asset(
                'assets/EST.png', // Placeholder image URL
                height: 300,
                width: 500,
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 10),
              // ignore: prefer_const_constructors
              Text(
                'Welcome to Cellule',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // ignore: prefer_const_constructors
              Text(
                'Discover attractive login, signup and forgot password and implement it in your code.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(179, 70, 70, 70),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromARGB(255, 149, 60, 5), // Text color
                  minimumSize: Size(double.infinity, 50), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color.fromARGB(255, 149, 60, 5), // Text color
                  minimumSize: Size(double.infinity, 50), 
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
