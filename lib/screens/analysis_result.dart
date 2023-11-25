import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'recipe_detail.dart';

class AnalysisResultPage extends StatelessWidget {
 final Map<String, dynamic> analysisResult;

  AnalysisResultPage({required this.analysisResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('分析結果'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '影像辨識結果: ${analysisResult['class_name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '信心指數: ${analysisResult['confidence_score']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              '營養資訊: ${analysisResult['fruit_nutrition']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              '此水果可以預防: ${analysisResult['fruit_prevention']}',
              style: const TextStyle(fontSize: 16),
            ),
            Divider(height: 20, color: Colors.grey[600]),
            const Text(
              '相關食譜:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: analysisResult['recipe_list'].length,
                itemBuilder: (context, index) {
                  var recipe = analysisResult['recipe_list'][index];
                  Uint8List imageBytes = base64Decode(recipe['picture']);

                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset:const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      '${recipe['title']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('食材: ${recipe['ingredients']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            id: recipe['id']!,
                            title: recipe['title']!,
                            step: (recipe['steps'] as List).join('\n'),
                            ingredient: recipe['ingredients']!,
                            picture: recipe['picture'] ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
