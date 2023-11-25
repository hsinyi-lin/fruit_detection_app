import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'analysis_result.dart';

class FruitCapture extends StatefulWidget {
  const FruitCapture({Key? key}) : super(key: key);

  @override
  _FruitCaptureState createState() => _FruitCaptureState();
}

class _FruitCaptureState extends State<FruitCapture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture = Future<void>.value();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _sendBase64ImageToBackend(String base64Image, Function(dynamic) navigateToResult) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:8000/fruit_detection/'),
        body: jsonEncode({'photo': base64Image}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData =
            json.decode(const Utf8Decoder().convert(response.bodyBytes));

        navigateToResult(responseData);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
      if (mounted) {
        setState(() {}); // Trigger a rebuild once the controller is initialized
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeControllerFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                try {
                  final XFile file = await _controller.takePicture();
                  final bytes = await file.readAsBytes();

                  // Convert bytes to base64
                  String base64Image = base64Encode(bytes);
                  await _sendBase64ImageToBackend(base64Image, (responseData) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnalysisResultPage(analysisResult: responseData),
                      ),
                    );
                  });
                } catch (e) {
                  print('Error occurred: $e');
                }
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              child: Icon(Icons.camera),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(_controller),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
