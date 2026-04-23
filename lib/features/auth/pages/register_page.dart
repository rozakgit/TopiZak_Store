import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isObscure = true;

  Future<void> register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field harus diisi")),
      );
      return;
    }

    // 🔥 VALIDASI EMAIL
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
        .hasMatch(emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Format email tidak valid")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user == null) throw Exception("User null");

      await user.updateDisplayName(nameController.text);

      // 🔥 EMAIL VERIFICATION
      await user.sendEmailVerification();
      print("Email verifikasi dikirim ke: ${user.email}");

      // 🔥 FIRESTORE (AMAN)
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'created_at': DateTime.now(),
        });
      } catch (e) {
        print("Firestore error: $e");
      }

      await FirebaseAuth.instance.signOut();

      if (!mounted) return;
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Akun berhasil dibuat, cek email untuk verifikasi (cek spam juga)"),
        ),
      );

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      String message = "Register gagal";

      switch (e.code) {
        case 'email-already-in-use':
          message = "Email sudah digunakan";
          break;
        case 'weak-password':
          message = "Password minimal 6 karakter";
          break;
        case 'invalid-email':
          message = "Format email tidak valid";
          break;
        case 'network-request-failed':
          message = "Tidak ada koneksi internet";
          break;
      }

      if (!mounted) return;
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

    } catch (e) {
      print("REGISTER ERROR: $e");

      if (!mounted) return;
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
                        "assets/image/logo.jpg",
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

              // 🔥 CARD
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
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 25),

                        // NAMA
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Nama",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

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

                        SizedBox(height: 15),

                        // PHONE
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "No HP",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

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

                        // BUTTON
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: isLoading ? null : register,
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Daftar"),
                          ),
                        ),

                        SizedBox(height: 20),

                        // LOGIN
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sudah punya akun? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
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