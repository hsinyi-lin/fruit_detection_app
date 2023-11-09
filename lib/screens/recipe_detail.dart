import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String imagePath;
  final String recipeName;

  RecipeDetailScreen({required this.imagePath, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: RecipeDetailContent(imagePath: imagePath, recipeName: recipeName),
    );
  }
}

class RecipeDetailContent extends StatelessWidget {
  final String imagePath;
  final String recipeName;

  RecipeDetailContent({required this.imagePath, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '食譜資訊：這是有關 $recipeName 的詳細資訊。',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
