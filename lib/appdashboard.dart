import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppDashboard extends StatefulWidget {
  const AppDashboard({Key? key}) : super(key: key);

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

class _AppDashboardState extends State<AppDashboard> {
  List<dynamic> fictionBooks = [];
  List<dynamic> nonFictionBooks = [];
  List<dynamic> academicBooks = [];

  @override
  void initState() {
    super.initState();
    fetchFictionBooks();
    fetchNonFictionBooks();
    fetchAcademicBooks();
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

  Widget buildBookRow(List<dynamic> books) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    base64Decode(book['imageUrl'].split(',').last),
                    height: 180,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book['title'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book['author'] ?? '',
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = "movindu";

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            color: Colors.blue[900],
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.account_circle, color: Colors.white, size: 32),
                const SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),

          // Fiction Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Fiction',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Non-Fiction',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Academic & Education',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
        ],
      ),
    );
  }
}
