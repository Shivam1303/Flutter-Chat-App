import 'dart:convert';
import 'dart:developer';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
// import 'package:chat_app/pages/googleauth';
import 'package:chat_app/pages/loginpage.dart';
import 'package:chat_app/pages/profile.dart';
import 'package:chat_app/widgets/user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Chat App"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        user: list[0],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 7, 106, 255),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: Apis.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list = data!.map((e) => ChatUser.fromJson(e.data())).toList();

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // return ChatCard();
                    return ChatCard(user: list[index]);
                  },
                );
              } else {
                return const Center(
                  child: Text("No users found !"),
                );
              }
          }
        },
      ),
    );
  }
}
