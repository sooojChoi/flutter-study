import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test1/ch24_firebase/screens/homeScreen.dart';
import 'package:test1/ch24_firebase/sign.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FirebaseApp());
}

class FirebaseApp extends StatefulWidget {
  const FirebaseApp({super.key});

  @override
  State<FirebaseApp> createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  bool loginStatus = false;

  reload(loginStatus) {
    this.loginStatus = loginStatus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      loginStatus = true;
      debugPrint(FirebaseAuth.instance.currentUser?.uid);
    } else {
      loginStatus = false;
    }

    return loginStatus
        ? MaterialApp(
            home: HomeScreen(mainReload: reload),
          )
        : MaterialApp(
            home: Scaffold(
              // HomeScreen 위젯의 하위 위젯은 SignInfo 상태 이용 가능.
              body: SafeArea(
                child: SignIn(
                  mainReload: reload,
                ),
              ),
            ),
          );
  }
}
