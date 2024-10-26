import 'package:flutter/material.dart';
import 'package:recipe/screen/RecipePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePreferences();
  runApp(MainApp());
}

Future<void> initializePreferences() async {
  final prefs = await SharedPreferences.getInstance();
  // Logika inisialisasi lainnya
  // Contoh menyimpan nilai default
  // await prefs.setString('key', 'value');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Recipepage(),
    );
  }
}
