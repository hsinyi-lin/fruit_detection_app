import 'package:flutter/material.dart';
import 'recipe_detail.dart';

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('美味食譜'),
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
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> recipes;

  RecipeSearch(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Implement search results UI
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : recipes.where((recipe) {
            return recipe['recipeName']
                .toLowerCase()
                .contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index]['recipeName'],
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            query = suggestionList[index]['recipeName'];
            // TODO: Handle tapping on a search suggestion
          },
        );
      },
    );
  }
}
