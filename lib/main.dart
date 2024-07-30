import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'eshop-project/viewscreen/e-shop_login_screen.dart';
import 'eshop-project/viewscreen/e-shop_splash_screen.dart';
import 'firebase_options.dart';
import 'newsproject/news_search_screen.dart';
import 'newsproject/news_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'New',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: NewsSearchView() ,
        home: EshopSplashScreen() ,
      ),
    );
  }
}
