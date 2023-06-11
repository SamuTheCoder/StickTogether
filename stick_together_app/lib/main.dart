import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stick_together_app/home_page.dart';
import 'package:stick_together_app/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> _isLoggedIn() async {
    final String? username = await _secureStorage.read(key: 'username');
    return username != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "StickTogether",
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data == true) {
            const Scaffold(
              body: Center(
                child: Text('Cargando...'),
              ),
            );
            Future.delayed(const Duration(seconds: 3));
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
