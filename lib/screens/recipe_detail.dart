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
        title: Text(recipeName),
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

  // 假設的數據源，可以替換為實際的數據源
  final Map<int, String> recipeData = {
    1: '這是有關 美味食譜1 的詳細資訊。',
    2: '這是有關 美味食譜2 的詳細資訊。',
    3: '這是有關 美味食譜3 的詳細資訊。',
    4: '這是有關 美味食譜4 的詳細資訊。',
  };

  @override
  Widget build(BuildContext context) {
    // 根據 id 獲取食譜的詳細資訊
    final String recipeInfo = recipeData[id] ?? '沒有找到相應的食譜資訊';

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
            '食譜資訊：$recipeInfo',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
