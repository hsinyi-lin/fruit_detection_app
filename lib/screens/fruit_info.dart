import 'package:flutter/material.dart';

class FruitInfo extends StatelessWidget {
  const FruitInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> fruits = [
      {
        'id': 1,
        'icon': Icons.star,
        'name': '蘋果',
        'description': '蘋果是一種美味且營養豐富的水果。',
      },
      {
        'id': 2,
        'icon': Icons.local_florist,
        'name': '香蕉',
        'description': '香蕉是一種富含鉀和維生素的水果。',
      },
      {
        'id': 3,
        'icon': Icons.local_florist,
        'name': '葡萄',
        'description': '葡萄是一種天然的抗氧化劑。',
      },
      // Add more fruit information
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return FruitInfoItem(
            id: fruits[index]['id'],
            icon: fruits[index]['icon'],
            name: fruits[index]['name'],
            description: fruits[index]['description'],
          );
        },
      ),
    );
  }
}

class FruitInfoItem extends StatelessWidget {
  final int id;
  final IconData icon;
  final String name;
  final String description;

  const FruitInfoItem({
    Key? key,
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 36.0,
          color: Colors.orange, // Change the icon color as needed
        ),
        title: Text(
          '$name',
          style: TextStyle(
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
          title: Text('$name (ID: $id)'),
          content: Text(
            description,
            style: TextStyle(fontSize: 16.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '關閉',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue, // Change the button color as needed
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
