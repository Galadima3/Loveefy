//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loveefy/src/features/auth/presentation/screens/profile_details.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loveefy/src/core/validator.dart';
import 'package:loveefy/src/features/auth/data/auth_repository.dart';
import 'package:loveefy/src/features/auth/presentation/shared_widgets/fancy_button.dart';

class EmailRegistrationScreen extends ConsumerStatefulWidget {
  const EmailRegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState
    extends ConsumerState<EmailRegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future onSubmit({required String email, required String password}) async {
    if (_formKey.currentState!.validate()) {
     final user = await ref
          .read(authRepositoryProvider)
          .signUp(emailController.text, passwordController.text);
         

      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return ProfileDetails(user: user!,);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 75),
              Center(
                child: SvgPicture.asset('asset/images/agreement.svg',
                    width: 200, height: 200),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.5, 10, 0, 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign up',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
              ),

              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    validator: (value) => Validator.validateEmail(email: value),
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
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        Validator.validatePassword(password: value),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          children: const [
                        TextSpan(text: 'By signing up, you agree to our '),
                        TextSpan(
                            text: 'Terms & Conditions ',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(text: 'and '),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.blue)),
                      ])),
                ),
              ),
              const SizedBox(height: 15),

              //button
              GestureDetector(
                onTap: () => onSubmit(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim()),
                child: const FancyButton(text: 'Continue'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
