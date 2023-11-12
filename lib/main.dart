import 'package:flutter/material.dart';
import 'screens/recipe.dart';
import 'screens/fruit_info.dart';
import 'screens/fruit_capture.dart';
import 'screens/recipe_community.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppHome(),  // 使用 MyAppHome 作為首頁
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  String _appBarTitle = '食譜清單'; 
  late Widget _currentBody = const RecipeList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),  // 更新 AppBar 標題
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text('食譜清單'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _appBarTitle = '食譜清單'; 
                  _currentBody = const RecipeList();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('水果資訊'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _appBarTitle = '水果資訊'; 
                  _currentBody = const FruitInfo();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt), 
              title: const Text('水果拍攝'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _appBarTitle = '水果拍攝';
                  _currentBody = const FruitCapture();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.group), 
              title: const Text('食譜社群'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _appBarTitle = '食譜社群';
                  _currentBody = const RecipeCommunity();
                });
              },
            ),
          ],
        ),
      ),
      body: _currentBody,
    );
  }
}
