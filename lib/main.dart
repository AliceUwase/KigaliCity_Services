import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'logic/cubits/directory/directory_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KigaliCityServicesApp());
}

class KigaliCityServicesApp extends StatelessWidget {
  const KigaliCityServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DirectoryCubit(),
      child: MaterialApp(
        title: 'Kigali City Services',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
  }
}
