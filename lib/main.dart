import 'theme.dart';
import 'package:flutter/material.dart';
import './Screens/SplashScreen/Splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "FixItParts",
        debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
        home: const SplashPage(),
    );
  }
}