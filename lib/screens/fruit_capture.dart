import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class FruitCapture extends StatefulWidget {
  const FruitCapture({Key? key}) : super(key: key);

  @override
  _FruitCaptureState createState() => _FruitCaptureState();
}

class _FruitCaptureState extends State<FruitCapture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // 獲取可用的相機
    availableCameras().then((cameras) {
      // 如果相機列表為空，不進行初始化
      if (cameras.isEmpty) return;

      // 選擇第一個相機
      _controller = CameraController(cameras[0], ResolutionPreset.medium);

      // 初始化相機控制器
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('水果拍攝'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 如果初始化完成，顯示相機預覽
            return CameraPreview(_controller);
          } else if (snapshot.hasError) {
            // 如果初始化出現錯誤，顯示錯誤信息
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // 如果尚未完成，顯示加載中的提示
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // 拍攝照片
            final XFile file = await _controller.takePicture();

            // TODO: 處理拍攝的照片，例如顯示、上傳等

            print('照片已拍攝：${file.path}');
          } catch (e) {
            print('錯誤發生：$e');
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }

  @override
  void dispose() {
    // 釋放相機資源
    _controller.dispose();
    super.dispose();
  }
}
