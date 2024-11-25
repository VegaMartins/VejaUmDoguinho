import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DoguinhoTest(),
    );
  }
}

class DoguinhoTest extends StatefulWidget {
  const DoguinhoTest({super.key});

  @override
  State<DoguinhoTest> createState() => _DoguinhoTestState();
}

class _DoguinhoTestState extends State<DoguinhoTest> {
  String? imageUrl;
  String? error;

  Future<void> fetchDog() async {
    try {
      final response = await http.get(
        Uri.parse('https://dog.ceo/api/breeds/image/random'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          imageUrl = data['message'];
          error = null;
        });
      } else {
        setState(() {
          error = 'Erro na requisição: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Está triste?'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchDog,
              child: const Text('Veja um Doguinho'),
            ),
            const SizedBox(height: 20),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red))
            else if (imageUrl != null)
              Container(
                height: 300,
                width: 300,
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}