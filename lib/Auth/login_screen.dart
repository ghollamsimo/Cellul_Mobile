import 'package:flutter/material.dart';
import 'package:flutter_pr/Auth/forgot_password.dart';
import 'package:flutter_pr/Services/Auth_Service.dart';
import 'package:flutter_pr/Student_App/Home_screen.dart'; // Ensure this import points to the correct file

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Cellule',
                  style: TextStyle(
                    color: Color.fromARGB(255, 149, 60, 5),
                    fontSize: 46,
                    fontFamily: 'Cursive',
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  style:
                      TextStyle(color: const Color.fromARGB(255, 36, 36, 36)),
                  decoration: InputDecoration(
                    labelText: 'Email or username',
                    labelStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                    prefixIcon: Icon(Icons.email,
                        color: const Color.fromARGB(179, 0, 0, 0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(179, 101, 101, 101)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(179, 101, 101, 101)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or username';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                            .hasMatch(value) &&
                        !RegExp(r"^[a-zA-Z0-9._%+-]{3,16}$").hasMatch(value)) {
                      return 'Please enter a valid email or username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(179, 0, 0, 0)),
                    prefixIcon: Icon(Icons.lock,
                        color: const Color.fromARGB(179, 0, 0, 0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(179, 101, 101, 101)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(179, 101, 101, 101)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: const Color.fromARGB(179, 0, 0, 0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      try {
                        final result =
                            await AuthService.login(context, email, password);
                        print('Login successful: $result');
                        final userId =
                            result['user']['id']; // Extract the user ID
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login successful!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                                userId: userId), // Pass user ID to HomePage
                          ),
                        );
                      } catch (e) {
                        print('Login failed: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor:
                        Color.fromARGB(255, 149, 60, 5), // Text color
                    minimumSize: Size(double.infinity, 50), // Full width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Handle sign up navigation
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
