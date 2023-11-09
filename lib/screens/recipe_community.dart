import 'package:flutter/material.dart';

class RecipeCommunity extends StatelessWidget {
  const RecipeCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('這裡顯示食譜社群內容'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('點擊新增按鈕');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
