import 'package:flutter/material.dart';
import 'recipe_detail.dart';

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
  final List<Map<String, dynamic>> recipes = [
    {
      'id': 1,
      'imagePath': 'assets/images/recipe1.jpg',
      'recipeName': '美味食譜1',
    },
    {
      'id': 2,
      'imagePath': 'assets/images/recipe2.jpg',
      'recipeName': '美味食譜2',
    },
    {
      'id': 3,
      'imagePath': 'assets/images/recipe1.jpg',
      'recipeName': '美味食譜3',
    },
    {
      'id': 4,
      'imagePath': 'assets/images/recipe2.jpg',
      'recipeName': '美味食譜4',
    },
    // Add more recipe data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          id: recipe['id']!,
          imagePath: recipe['imagePath']!,
          recipeName: recipe['recipeName']!,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  id: recipe['id']!,
                  imagePath: recipe['imagePath']!,
                  recipeName: recipe['recipeName']!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final int id;
  final String imagePath;
  final String recipeName;
  final VoidCallback onPressed;

  RecipeCard({
    required this.id,
    required this.imagePath,
    required this.recipeName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
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
      ),
    );
  }
}
