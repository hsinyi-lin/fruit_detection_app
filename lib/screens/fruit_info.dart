import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fruit {
  final int id;
  final String name;
  final String nutrition;
  final String prevent;

  Fruit({
    required this.id,
    required this.name,
    required this.nutrition,
    required this.prevent,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      id: json['id'],
      name: json['name'],
      nutrition: json['nutrition'],
      prevent: json['prevent'],
    );
  }
}

class FruitInfo extends StatelessWidget {
  const FruitInfo({Key? key}) : super(key: key);

  Future<List<Fruit>> fetchFruits() async {
    final response =
        await http.get(Uri.parse(''));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
      final List<dynamic> fruitList = data['data'];
      print(data);
      return fruitList.map((json) => Fruit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load fruits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Fruit>>(
      future: fetchFruits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Fruit> fruits = snapshot.data!;
          return Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                return FruitInfoItem(
                  fruit: fruits[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}

class FruitInfoItem extends StatelessWidget {
  final Fruit fruit;

  const FruitInfoItem({
    Key? key,
    required this.fruit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.local_florist, // Assuming a default icon for now
          size: 36.0,
          color: Colors.orange,
        ),
        title: Text(
          fruit.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        onTap: () {
          _showFruitDetails(context);
        },
      ),
    );
  }

  void _showFruitDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(fruit.name),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '營養成分',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    fruit.nutrition,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0), 
                  const Text(
                    '預防項目',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    fruit.prevent,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
