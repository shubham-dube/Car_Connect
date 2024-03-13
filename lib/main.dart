import 'theme.dart';
import 'package:flutter/material.dart';
import './Screens/SplashScreen/Splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'Cart_Model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: App(),
    ),
  );
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