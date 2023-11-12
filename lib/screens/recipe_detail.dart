import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class RecipeDetailScreen extends StatelessWidget {
  final int id;
  final String title;
  final String step;
  final String ingredient;
  final String picture;

  const RecipeDetailScreen({
    required this.id,
    required this.title,
    required this.step,
    required this.ingredient,
    required this.picture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String trimmedPicture = picture.substring(2, picture.length - 1);
    Uint8List bytes = base64Decode(trimmedPicture);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12.0),
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
                image: DecorationImage(
                  image: MemoryImage(bytes),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0), // Adjust spacing here
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ingredient,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                step
                    .split(' ')
                    .asMap()
                    .entries
                    .map((entry) => '${entry.key + 1}. ${entry.value}')
                    .join('\n'),
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
