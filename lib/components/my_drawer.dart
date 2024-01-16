// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //drawer header
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              //home title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("H O M E"),
                  onTap: () {
                    //its home page so just pop drawer

                    Navigator.pop(context);
                  },
                ),
              ),

              //profile title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    //its home page so just pop drawer

                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              // user title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.group,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("U S E R S"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),
          //logout title
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary),
              title: const Text("L O G O U T"),
              onTap: () {
                //its home page so just pop drawer

                Navigator.pop(context);

                //logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
