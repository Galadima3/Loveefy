import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loveefy/src/features/auth/data/auth_repository.dart';
import 'package:loveefy/src/features/auth/presentation/auth_checker.dart';
import 'package:loveefy/src/features/auth/presentation/screens/landing_page.dart';
import 'package:loveefy/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(ProviderScope(
      child: MyApp(
    showHome: showHome,
  )));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loveefy',
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: showHome ? AuthChecker() : const OnboardingScreen(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Future<String> getImageUrl() async {
    // Reference the Firebase Storage bucket and file path of your image
    final ref =
        FirebaseStorage.instance.ref().child('files/img_20230620_204950.jpg');

    // Get the download URL for the image
    final url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    log('Home Page User =>${widget.user}');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(authRepositoryProvider).signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child:
            Text('Home Page => ${widget.user!.displayName ?? 'Unavailable'}'),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
