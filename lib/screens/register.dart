import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> registerUser(String email, String password, String nickname, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(''),
        body: {
          'email': email,
          'password': password,
          'nickname': nickname,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('註冊成功')),
        );

        // 清除 input 所有內容
        _emailController.clear();
        _passwordController.clear();
        _nicknameController.clear();

        print('Registration successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('註冊失敗: ${response.statusCode}')),
        );
        print('Registration failed: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: '電子郵件',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: '密碼',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nicknameController,
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: '名稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                registerUser(
                  _emailController.text,
                  _passwordController.text,
                  _nicknameController.text,
                  context,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: const Text('註冊'),
            ),
          ],
        ),
      ),
    );
  }
}
