import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('食譜清單'),
      ),
      body: RecipeList(),
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<String> recipeImages = [
    'assets/images/recipe1.jpg',
    'assets/images/recipe2.jpg',
    'assets/images/recipe1.jpg',
    'assets/images/recipe2.jpg',
    // Add more image paths as needed
  ];

  final List<String> recipeNames = [
    '美味食譜1',
    '美味食譜2',
    '美味食譜1',
    '美味食譜2',
    // Add more recipe names as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipeImages.length,
      itemBuilder: (context, index) {
        return RecipeCard(
          imagePath: recipeImages[index],
          recipeName: recipeNames[index],
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String recipeName;

  RecipeCard({required this.imagePath, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              recipeName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
