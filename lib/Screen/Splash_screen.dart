import 'package:flutter/material.dart';
import 'package:flutter_pr/Student_App/Home_screen.dart';
import 'package:splash_view/source/presentation/presentation.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashView(
        loadingIndicator: const Text('Cellule Listening', style: TextStyle(fontSize: 21),),
        bottomLoading: true,
        backgroundColor: Colors.white,
      
        done: Done(HomeScreen()),
      ),
    );
  }
}


