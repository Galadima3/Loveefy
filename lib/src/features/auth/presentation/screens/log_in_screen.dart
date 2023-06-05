import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loveefy/main.dart';
import 'package:loveefy/src/core/validator.dart';
import 'package:loveefy/src/features/auth/data/auth_repository.dart';

import 'package:loveefy/src/features/auth/presentation/shared_widgets/fancy_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = true;

  Future onSubmit(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (_formKey.currentState!.validate() &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      final user = await AuthRepository()
          .signInUsingEmailPassword(email: email, password: password);
      if (user != null) {
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage(user: user);
          },
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: SvgPicture.asset('asset/images/tinder.svg',
                      width: 200, height: 200),
                ),
                const SizedBox(height: 85),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.validateEmail(email: value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      obscureText: isPasswordVisible,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () => onSubmit(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      context: context),
                  child: const FancyButton(
                    text: 'Log in',
                  ),
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
