import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'logic/cubits/directory/directory_cubit.dart';
import 'data/repositories/place_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final placeRepository = PlaceRepository();
  runApp(KigaliCityServicesApp(placeRepository: placeRepository));
}

class KigaliCityServicesApp extends StatelessWidget {
  final PlaceRepository placeRepository;

  const KigaliCityServicesApp({super.key, required this.placeRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: placeRepository)],
      child: BlocProvider(
        create: (context) => DirectoryCubit(placeRepository),
        child: MaterialApp(
          title: 'Kigali City Services',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
