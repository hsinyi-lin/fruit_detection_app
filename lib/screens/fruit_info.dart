import 'package:flutter/material.dart';

class FruitInfo extends StatelessWidget {
  const FruitInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用 List<Map> 來表示水果資訊
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
      // 添加更多水果資訊
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
    return ListTile(
      leading: Icon(icon),
      title: Text('$name'),
      onTap: () {
        _showFruitDetails(context);
      },
    );
  }

  void _showFruitDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$name (ID: $id)'),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('關閉'),
            ),
          ],
        );
      },
    );
  }
}
