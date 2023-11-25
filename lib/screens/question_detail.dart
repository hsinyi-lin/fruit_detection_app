import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class QuestionDetailPage extends StatefulWidget {
  final int questionId;

  const QuestionDetailPage({Key? key, required this.questionId}): super(key: key);

  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  late Future<Map<String, dynamic>> _questionDetail;
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _questionDetail = fetchQuestionDetail(widget.questionId);
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); 

    // 確認 token 存在
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  Future<Map<String, dynamic>> fetchQuestionDetail(int questionId) async {
    final response = await http.get(Uri.parse(''));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
      return data['data'];
    } else {
      throw Exception('Failed to load question details');
    }
  }

  Future<void> _postAnswer(String enteredAnswer) async {
    const String apiUrl = '';

    final Map<String, dynamic> data = {
      'question_id': widget.questionId,
      'content': enteredAnswer,
    };

    const String token = ''; 
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Handle success response
        print('Answer posted successfully');

        setState(() {
          _questionDetail = fetchQuestionDetail(widget.questionId);
        });
      } else {
        // Handle error response
        print('Failed to post answer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _showInputDialog() {
    if (!isLoggedIn) {
      // 若使用者未登入，顯示警示訊息
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請先登入才能新增回答')),
      );
      // 也可在這裡導向登入頁面或執行其他登入流程
      return;
    }
    String enteredAnswer = ''; // 變數用於儲存輸入的答案
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('新增回答'),
          content: SizedBox(
            width: double.maxFinite,
            child: TextField(
              decoration: const InputDecoration(
                hintText: '輸入你的答覆',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                enteredAnswer = value; // 更新輸入的答案
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // 在這裡處理輸入的答案
                print('輸入的答案是：$enteredAnswer');
                _postAnswer(enteredAnswer);

                // setState(() {
                //   _questionDetail = fetchQuestionDetail(widget.questionId);
                // });
                Navigator.of(context).pop();
              },
              child: const Text('送出'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('內容'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _questionDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              final Map<String, dynamic> questionDetail = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questionDetail['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    questionDetail['content'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'From: ${questionDetail['nickname']}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Answers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (var answer in questionDetail['answers'])
                    ListTile(
                      title: Text(answer['content']),
                      subtitle: Text(
                        'By: ${answer['answer_nickname']}',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                  
                  ElevatedButton(
                    onPressed: _showInputDialog,
                    child: const Text('新增回答'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
