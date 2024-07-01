// register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_pr/Auth/login_screen.dart';
import 'package:flutter_pr/Services/auth_service.dart'; // Import your AuthService

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _cinNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _hiddenFieldController =
      TextEditingController(text: 'Student');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cellule Ecoute',
                    style: TextStyle(
                      color: Color.fromARGB(255, 149, 60, 5),
                      fontSize: 36,
                      fontFamily: 'Cursive',
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          style:
                              TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(179, 0, 0, 0)),
                            prefixIcon: Icon(Icons.person,
                                color: Color.fromARGB(179, 86, 86, 86)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(179, 101, 101, 101)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(179, 101, 101, 101)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _cinNumberController,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            labelText: 'CIN',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(179, 0, 0, 0)),
                            prefixIcon: Icon(Icons.numbers,
                                color: const Color.fromARGB(179, 82, 82, 82)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(179, 101, 101, 101)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(179, 101, 101, 101)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your CIN';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: const Color.fromARGB(179, 0, 0, 0)),
                      prefixIcon: Icon(Icons.email,
                          color: const Color.fromARGB(179, 95, 94, 94)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(179, 101, 101, 101)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(179, 101, 101, 101)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _phonenumberController,
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(179, 0, 0, 0)),
                        prefixIcon: Icon(Icons.numbers,
                            color: const Color.fromARGB(179, 95, 94, 94)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(179, 101, 101, 101)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(179, 101, 101, 101)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone Number';
                        }
                      }),
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
                          color: const Color.fromARGB(179, 76, 76, 76)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(179, 101, 101, 101)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(179, 101, 101, 101)),
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
                  SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Visibility(
                        visible: false,
                        child: TextFormField(
                          controller: _hiddenFieldController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final fullName = _firstNameController.text;
                        final cin = _cinNumberController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final phoneNumber = _phonenumberController.text;
                        final role = _hiddenFieldController.text; // Fixed role

                        try {
                          final result = await AuthService.register(
                              fullName, password, email, role);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Registration successful!')));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        } catch (e) {
                          print('Registration failed: $e');
                          // Show an error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Registration failed: $e')));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      backgroundColor:
                          Color.fromARGB(255, 149, 60, 5), // Text color
                      minimumSize:
                          Size(double.infinity, 50), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Register'),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                            color: const Color.fromARGB(179, 0, 0, 0)),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
