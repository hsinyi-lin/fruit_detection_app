import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          // 點擊新增按鈕，導航到新增食譜的頁面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecipePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  late ImagePicker _imagePicker;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _selectedImage = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增食譜'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: '食譜標題'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(labelText: '食譜內容'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('上傳圖片'),
            ),
            const SizedBox(height: 16),
            if (_selectedImage != null)
              Image.file(
                File(_selectedImage!.path),
                height: 100,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: 處理儲存食譜的操作
                print('儲存食譜');
                Navigator.pop(context); // 返回前一個頁面
              },
              child: const Text('儲存食譜'),
            ),
          ],
        ),
      ),
    );
  }
}
