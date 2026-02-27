import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
// import 'core/theme/app_theme.dart';
import 'presentation/screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KigaliCityServicesApp());
}

class KigaliCityServicesApp extends StatelessWidget {
  const KigaliCityServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kigali City Services',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
