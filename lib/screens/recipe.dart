import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'recipe_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Recipe(),
    );
  }
}

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final response = await http.get(
      Uri.parse(''),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
      final List<dynamic> recipeList = data['data'];
      return recipeList.map((json) => json as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const RecipeList();
  }
}

class RecipeList extends StatelessWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _RecipeState().fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Map<String, dynamic>> recipes = snapshot.data!;
          return _buildRecipeList(recipes);
        }
      },
    );
  }

  Widget _buildRecipeList(List<Map<String, dynamic>> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          id: recipe['id']!,
          title: recipe['title']!,
          picture: recipe['picture'] ?? '',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  id: recipe['id']!,
                  title: recipe['title']!,
                  step: recipe['step']!,
                  ingredient: recipe['ingredient']!,
                  picture: recipe['picture'] ?? '',
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
  final String title;
  final String picture;
  final VoidCallback onPressed;

  const RecipeCard({
    required this.id,
    required this.title,
    required this.picture,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String trimmedPicture = picture.substring(2, picture.length - 1);
    Uint8List bytes = base64Decode(trimmedPicture);

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(
              bytes,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
