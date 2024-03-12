
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Function mainReload;
  int age = 20;
  var user = FirebaseAuth.instance.currentUser;
  HomeScreen({super.key, required this.mainReload});

  logout() async {
    await FirebaseAuth.instance.signOut();
    mainReload(false);
  }

  saveData() async {
    CollectionReference userRef = db.collection("user");

    if (user != null) {
      DocumentReference documentReference = await userRef.add({
        "email": user!.email,
        "name": user!.email!.split('@')[0],
        "age": age,
      });
    }
  }

  updateData() {
    CollectionReference userRef = db.collection("user");
    userRef.where('email', isEqualTo: user!.email).limit(1).get().then((value) {
      for (var element in value.docs) {
        userRef.doc(element.id).update({"age": ++age});
      }
    });
  }

  deleteData() {
    CollectionReference userRef = db.collection("user");
    userRef.where('email', isEqualTo: user!.email).limit(1).get().then((value) {
      for (var element in value.docs) {
        userRef.doc(element.id).delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: saveData,
              child: const Text(
                "현재 정보 저장",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: updateData,
              child: const Text(
                "정보 업데이트",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: deleteData,
              child: const Text(
                "정보 삭제",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: logout,
              child: const Text(
                "로그아웃",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
