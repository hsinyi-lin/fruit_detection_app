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
      },
      {
        'id': 2,
        'icon': Icons.local_florist,
        'name': '香蕉',
      },
      {
        'id': 3,
        'icon': Icons.ac_unit,
        'name': '葡萄',
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

  const FruitInfoItem({
    Key? key,
    required this.id,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
    );
  }
}