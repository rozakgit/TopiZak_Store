import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isObscure = true;

  // 🔥 LOGIN EMAIL
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email dan password wajib diisi")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;

      // 🔥 CEK EMAIL VERIFICATION
      if (user != null && !user.emailVerified) {
        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text("Email belum diverifikasi, cek email kamu dulu")),
        );
        return;
      }

    } on FirebaseAuthException catch (e) {
      String message = "Login gagal";

      switch (e.code) {
        case 'user-not-found':
          message = "Email tidak ditemukan";
          break;
        case 'wrong-password':
          message = "Password salah";
          break;
        case 'invalid-email':
          message = "Format email tidak valid";
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("LOGIN ERROR: $e");
    }

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  // 🔥 LOGIN GOOGLE
  Future<void> loginWithGoogle() async {
    setState(() => isLoading = true);

    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      // 🔥 SIMPAN KE FIRESTORE
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set({
        'name': user.displayName,
        'email': user.email,
        'photo': user.photoURL,
        'created_at': DateTime.now(),
      }, SetOptions(merge: true));

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google login gagal")),
      );
    }

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),

              // 🔥 LOGO
              Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/image/logo.jpg", // pastikan ada
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "TopiJak Store",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // 🔥 CARD LOGIN
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 25),

                        // EMAIL
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // PASSWORD
                        TextField(
                          controller: passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        // LOGIN BUTTON
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: isLoading ? null : login,
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Login"),
                          ),
                        ),

                        SizedBox(height: 15),

                        // 🔥 GOOGLE BUTTON
                        SizedBox(
                          height: 50,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: isLoading ? null : loginWithGoogle,
                            icon: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/300/300221.png",
                              height: 20,
                            ),
                            label: Text(
                              "Login dengan Google",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // REGISTER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Belum punya akun? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RegisterPage()),
                                );
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}