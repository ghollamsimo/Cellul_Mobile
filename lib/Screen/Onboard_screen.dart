import 'package:flutter/material.dart';

class Onboard extends StatelessWidget {
  final Image image;
  final String title;
  final String description;
  final TextStyle? titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final TextAlign? textAlign;

  const Onboard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.textAlign = TextAlign.center, // Default alignment is center
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
            ),
            image,
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: titleTextStyle,
              textAlign: textAlign,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: descriptionTextStyle,
              textAlign: textAlign,
            ),
          ],
        ),
      ),
    );
  }
}
