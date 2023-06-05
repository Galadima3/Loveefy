import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loveefy/src/features/auth/data/firestore_repository.dart';
import 'package:loveefy/src/features/auth/presentation/shared_widgets/fancy_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class ProfileDetails extends StatefulWidget {
  final User user;
  const ProfileDetails({super.key, required this.user});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  String? firstName;
  @override
  void initState() {
    super.initState();
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateController = TextEditingController();
  Future<void> onSubmit() async {
    await widget.user.updateDisplayName(
        "${firstNameController.text} ${lastNameController.text}");
    String uid = widget.user.uid;
    FirestoreRepository.addEntry1(firstNameController.text,
        lastNameController.text, dateController.text, widget.user.email!).then((value) {
          //return 
        });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateController.dispose();
    super.dispose();
  }

//  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile Details',
                    style:
                        TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                  )),
            ),
            //Text(widget.user.displayName!),
            const SizedBox(height: 20),
            //Picture
            Container(
              height: 101,
              width: 106,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(height: 20),

            //first name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.50),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: TextFormField(
                  //initialValue: firstName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'First name',
                      hintStyle: GoogleFonts.montserrat()),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //last name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.50),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Last name',
                      hintStyle: GoogleFonts.montserrat()),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //date of birth
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.50),
              child: TextField(
                  controller:
                      dateController, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Date of Birth" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      log(formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  }),
            ),
            const SizedBox(height: 20),
            //
            GestureDetector(
                onTap: () => onSubmit(),
                child: const FancyButton(
                  text: 'Confirm',
                ))
          ],
        ),
      ),
    ));
  }
}
