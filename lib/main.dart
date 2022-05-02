import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/conroller/mobilescreen.dart';
import 'package:insta_clone/conroller/responsive.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:insta_clone/conroller/webscreen.dart';
import 'package:insta_clone/constants/color.dart';
import 'package:insta_clone/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBKkTGpHkn9uD6Bt2JVRiShg902n0ekGIw',
            appId: "1:419574496814:web:f49792137190ddaca169bf",
            messagingSenderId: "419574496814",
            storageBucket: "insta-15eb5.appspot.com",
            projectId: "insta-15eb5"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Userprovider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const Responsive(
                    mobilescreen: Mobilescreen(),
                    webscreen: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const LoginScrren();
            }),
      ),
    );
  }
}
