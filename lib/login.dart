import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'newac.dart';
import 'appdashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController(); // Optional
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    HttpOverrides.global =
        MyHttpOverrides(); // Ignore SSL cert warning for local dev
  }

  Future<void> _loginUser() async {
    final url = Uri.parse('http://10.0.2.2:5078/api/auth/login');

    // Update if using real device

    try {
      final response = await http.post(
        url,
        body: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      AppDashboard(username: _usernameController.text.trim()),
            ),
          );
        } else {
          setState(() {
            _errorMessage = data['message'] ?? 'Login failed';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid server response (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D47A1), Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // White Login Box
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 15),

                      TextField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Username (optional)',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 15),

                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Login Button
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _loginUser,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purpleAccent.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewAccountScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create an Account',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Accept self-signed certificates for localhost
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
