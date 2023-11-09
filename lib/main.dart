import 'package:flutter/material.dart';
import 'screens/recipe.dart';
import 'screens/fruit_info.dart';
import 'screens/fruit_capture.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  String _appBarTitle = '食譜清單';  // 新增這行
  Widget _currentBody = RecipeList();

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
                  _appBarTitle = '食譜清單';  // 更新 AppBar 標題
                  _currentBody = RecipeList();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('水果資訊'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _appBarTitle = '水果資訊';  // 更新 AppBar 標題
                  _currentBody = const FruitInfo();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),  // 水果拍攝的 icon
              title: const Text('水果拍攝'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _appBarTitle = '水果拍攝';
                  _currentBody = const FruitCapture();
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
