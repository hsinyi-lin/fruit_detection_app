import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'add_question.dart';
import 'question_detail.dart';

class Question {
  final int id;
  final String title;
  final String content;
  final String email;

  Question({
    required this.id,
    required this.title,
    required this.content,
    required this.email,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      email: json['email'],
    );
  }
}

class RecipeCommunity extends StatefulWidget {
  const RecipeCommunity({Key? key}) : super(key: key);

  @override
  _RecipeCommunityState createState() => _RecipeCommunityState();
}

class _RecipeCommunityState extends State<RecipeCommunity> {
  late Future<List<Question>> _questions;
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _questions = fetchQuestions();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); 

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

  Future<List<Question>> fetchQuestions() async {
    final response =
        await http.get(Uri.parse(''));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
      final List<dynamic> questionList = data['data'];
      return questionList.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Question>>(
          future: _questions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Question> questions = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return QuestionItem(
                    question: questions[index],
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isLoggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddQuestionPage(),
              ),
            ).then((value) {
              if (value == true) {
                setState(() {
                  _questions = fetchQuestions();
                });
              }
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('請先登入才能使用新增功能')),
            );
          }
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class QuestionItem extends StatelessWidget {
  final Question question;

  const QuestionItem({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          question.title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(question.content),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionDetailPage(questionId: question.id),
            ),
          );
        },
      ),
    );
  }
}
