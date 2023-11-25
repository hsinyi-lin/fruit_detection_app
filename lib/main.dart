import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/recipe.dart';
import 'screens/fruit_info.dart';
import 'screens/fruit_capture.dart';
import 'screens/recipe_community.dart';
import 'screens/analysis_result.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppHome(),
      debugShowCheckedModeBanner: false,
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
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    setState(() {
      isLoggedIn = token != null && token.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
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
            Divider(), // Divider
            Visibility(
              visible: isLoggedIn, // Show logout only if the user is logged in
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('登出'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('登出成功')),
                  );
                  setState(() {
                    isLoggedIn = false; // Update login status
                  });
                },
              ),
            ),
            Visibility(
              visible: !isLoggedIn, // Show login/register if the user is not logged in
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text('登入'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _appBarTitle = '登入';
                        _currentBody = LoginPage();
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('註冊'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _appBarTitle = '註冊';
                        _currentBody = RegisterPage();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _currentBody,
    );
  }
}