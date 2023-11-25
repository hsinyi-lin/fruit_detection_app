import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _handleLogin(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(''), 
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(const Utf8Decoder().convert(response.bodyBytes));

        final token = responseData['access_token'];
        print(responseData);
        await saveToken(token);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('登入成功')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyAppHome()), 
        );
        
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login failed')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    String email = ''; // 儲存使用者email輸入
    String password = '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                email = value;   // 更新 email 內容
              },
              decoration: const InputDecoration(
                labelText: '電子郵件',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(
                labelText: '密碼',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _handleLogin(context, email,password);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: const Text('登入'),
            ),
          ],
        ),
      ),
    );
  }
}
