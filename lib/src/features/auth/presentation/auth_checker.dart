



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loveefy/main.dart';
import 'package:loveefy/src/features/auth/presentation/screens/landing_page.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  late Stream<User?> _authStateStream;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _authStateStream = FirebaseAuth.instance.authStateChanges();
    _authStateStream.listen((User? user) {
      // log('Auth state changed: $user');
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: _authStateStream,
          builder: (context, snapshot) {
            // log('Snapshot data: ${snapshot.data}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final user = snapshot.data ?? _currentUser;
              if (user != null) {
                return HomePage(user: user);
              } else {
                return const LandingScreen();
              }
            }
          },
        ),
      ),
    );
  }
}


