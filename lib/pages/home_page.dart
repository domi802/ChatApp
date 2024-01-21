// ignore_for_file: prefer_const_constructors

import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/components/my_list_tile.dart';
import 'package:chatapp/components/my_post_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();
  //Text Controller
  final TextEditingController newPostController = TextEditingController();

  //post message
  void postMessage() {
    //only post message if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    //clear controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("W A L L "),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //Text field for user type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                //TextField
                Expanded(
                  child: MyTextField(
                    hintText: "Say something",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                //postbutton
                PostButton(
                  onTap: postMessage,
                )
              ],
            ),
          ),
          //POST
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //no data?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts.. Post something!!!"),
                  ),
                );
              }

              // return as a list
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    //get each individual post
                    final post = posts[index];
                    //get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    // format timestamp
                    DateTime dateTime = timestamp.toDate();
                    String formattedTimestamp =
                        "${dateTime.day}-${dateTime.month}-${dateTime.year} • ${dateTime.hour}:${dateTime.minute}";
                    //return as list title
                    return MyListTile(
                        title: message,
                        subtitle: "$userEmail • $formattedTimestamp");
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
