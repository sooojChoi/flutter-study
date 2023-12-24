import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInfo with ChangeNotifier {
  bool isLogin = false;

  setLogin(isLogin) {
    this.isLogin = isLogin;
  }
}

class SignIn extends StatefulWidget {
  Function mainReload;
  SignIn({super.key, required this.mainReload});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controllerId = TextEditingController();
  final controllerPw = TextEditingController();
  var email = "";
  var pw = "";

  SignIn() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw)
          .then((value) => {widget.mainReload(true)});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.code);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  SignUp() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: TextField(
            style: const TextStyle(fontSize: 15),
            controller: controllerId,
            decoration: const InputDecoration(hintText: "이메일을 입력하세요.(@필수)"),
            onChanged: (value) {
              email = value;
            },
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: TextField(
            obscureText: true,
            style: const TextStyle(fontSize: 15),
            controller: controllerPw,
            decoration: const InputDecoration(hintText: "비밀번호를 입력하세요."),
            onChanged: (value) {
              pw = value;
            },
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: SignIn,
          child: const Text(
            "로그인",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: SignUp,
          child: const Text(
            "회원가입",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
