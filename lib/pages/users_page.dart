// ignore_for_file: prefer_const_constructors

import 'package:chatapp/components/my_list_tile.dart';
import 'package:chatapp/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/my_back_button.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          //any errors
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong", context);
          }
          //show loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Text("No data");
          }
          //get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0, left: 25.0),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    padding: EdgeInsets.only(top: 25),
                    itemBuilder: (context, index) {
                      //get individual user
                      final user = users[index];

                      //get data from each user
                      String username = user['username'];
                      String email = user['email'];

                      return MyListTile(title: username, subtitle: email);
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
