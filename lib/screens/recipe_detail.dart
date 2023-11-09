import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int id;
  final String imagePath;
  final String recipeName;

  RecipeDetailScreen({
    required this.id,
    required this.imagePath,
    required this.recipeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipeName,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[400], // Change the background color as needed
      ),
      body: RecipeDetailContent(id: id, imagePath: imagePath, recipeName: recipeName),
    );
  }
}

class RecipeDetailContent extends StatelessWidget {
  final int id;
  final String imagePath;
  final String recipeName;

  RecipeDetailContent({
    required this.id,
    required this.imagePath,
    required this.recipeName,
  });

  final Map<int, String> recipeData = {
    1: '這是有關 美味食譜1 的詳細資訊。',
    2: '這是有關 美味食譜2 的詳細資訊。',
    3: '這是有關 美味食譜3 的詳細資訊。',
    4: '這是有關 美味食譜4 的詳細資訊。',
  };

  @override
  Widget build(BuildContext context) {
    final String recipeInfo = recipeData[id] ?? '沒有找到相應的食譜資訊';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.white, // Background color for the recipe info
          child: Text(
            '食譜資訊：$recipeInfo',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
