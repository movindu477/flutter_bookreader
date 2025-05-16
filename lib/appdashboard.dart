import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui'; // For ImageFilter.blur
import 'package:intl/intl.dart'; // For date formatting

class AppDashboard extends StatefulWidget {
  final String username;

  const AppDashboard({Key? key, required this.username}) : super(key: key);

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

class _AppDashboardState extends State<AppDashboard> {
  List<dynamic> fictionBooks = [];
  List<dynamic> nonFictionBooks = [];
  List<dynamic> academicBooks = [];
  List<dynamic> comicsBooks = [];

  // Simulated last login time
  DateTime lastLoginTime = DateTime.now().subtract(Duration(hours: 2));

  @override
  void initState() {
    super.initState();
    fetchFictionBooks();
    fetchNonFictionBooks();
    fetchAcademicBooks();
    fetchComicsBooks();
  }

  Future<void> fetchFictionBooks() async {
    final url = Uri.parse('http://10.0.2.2:5078/api/fiction');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          fictionBooks = jsonDecode(response.body);
        });
      } else {
        print("Failed to load fiction books: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching fiction books: $e");
    }
  }

  Future<void> fetchNonFictionBooks() async {
    final url = Uri.parse('http://10.0.2.2:5078/api/nonfiction');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          nonFictionBooks = jsonDecode(response.body);
        });
      } else {
        print("Failed to load non-fiction books: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching non-fiction books: $e");
    }
  }

  Future<void> fetchAcademicBooks() async {
    final url = Uri.parse('http://10.0.2.2:5078/api/academicbooks');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          academicBooks = jsonDecode(response.body);
        });
      } else {
        print("Failed to load academic books: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching academic books: $e");
    }
  }

  Future<void> fetchComicsBooks() async {
    final url = Uri.parse('http://10.0.2.2:5078/api/comics');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          comicsBooks = jsonDecode(response.body);
        });
      } else {
        print("Failed to load comics books: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching comics books: $e");
    }
  }

  Widget buildBookRow(List<dynamic> books) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.memory(
                          base64.decode(book['imageUrl'].split(',').last),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book['title'] ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              book['author'] ?? '',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
        },
      ),
    );
  }

  // Right-side drawer widget
  Widget buildProfileDrawer(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMM yyyy, hh:mm a');
    return Drawer(
      elevation: 16,
      backgroundColor: Colors.transparent,
      child: Align(
        alignment: Alignment.centerRight,
        child: FractionallySizedBox(
          widthFactor: 0.75,
          child: Material(
            color: Colors.blue[900],
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, size: 60, color: Colors.white),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Active",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Last Login: ${formatter.format(lastLoginTime)}",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.white30),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text(
                      "Settings",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      // Handle logout logic
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      endDrawer: buildProfileDrawer(context), // Retain the drawer definition
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A237E), // Dark Blue
              Color(0xFF4A148C), // Deep Purple
            ],
          ),
        ),
        child: ListView(
          children: [
            // Status bar padding
            SizedBox(height: MediaQuery.of(context).padding.top),

            // Header with user info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Profile icon (no InkWell)
                  Icon(Icons.account_circle, color: Colors.white, size: 32),
                  const SizedBox(width: 8),
                  // Username (no InkWell)
                  Text(
                    widget.username,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            // Section Headers and Book Rows Below...

            // Fiction Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'Fiction',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child:
                  fictionBooks.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : buildBookRow(fictionBooks),
            ),

            // Non-Fiction Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Non-Fiction',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child:
                  nonFictionBooks.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : buildBookRow(nonFictionBooks),
            ),

            // Academic Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Academic & Education',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 30),
              child:
                  academicBooks.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : buildBookRow(academicBooks),
            ),

            // Comics & Graphic Novels Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Comics & Graphic Novels',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 30),
              child:
                  comicsBooks.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : buildBookRow(comicsBooks),
            ),
          ],
        ),
      ),
    );
  }
}
