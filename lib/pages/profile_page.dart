// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current user logged
  User? currentUser = FirebaseAuth.instance.currentUser;

  // future tu fetch user details

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: ((context, snapshot) {
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //error
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          //data
          else if (snapshot.hasData) {
            //extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 25.0),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  //profile page
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24)),
                    padding: EdgeInsets.all(25),
                    child: const Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //username
                  Text(
                    user!['username'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //email
                  Text(
                    user['email'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          } else {
            return const Text("No data");
          }
        }),
      ),
    );
  }
}
