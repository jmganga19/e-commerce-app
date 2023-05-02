import 'package:chat_ai/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'constants/pallete.dart';
import 'package:flutter/material.dart';
import 'constants/splash.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'providers/app_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
        title: 'Gstore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Pallete.backgroundColor,
            appBarTheme:
                const AppBarTheme(backgroundColor: Pallete.whiteColor)),
        home: const ScreenController()),
    ),
  );
}

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return  LoginPage();
      case Status.Authenticated:
        return const Home();
      default:
        return  LoginPage();
    }
  }
}

// 

