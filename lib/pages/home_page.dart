import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intermediate_mobile_amcc24/pages/detai_note_page.dart';
import 'package:intermediate_mobile_amcc24/shared/themes/theme.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    final snapshot = await _firestore.collection('notes').get();
    setState(() {
      notes = snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
    });
  }

  void openAddNotePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddNotePage(onSave: (String title, String content) {
          addNewNote(title, content);
          Navigator.pop(context);
        }),
      ),
    );
  }

  void addNewNote(String title, String content) async {
    await _firestore.collection('notes').add({
      'title': title,
      'content': content,
      'date': DateTime.now().toString(),
      'status': 'Just Now',
    });
    fetchNotes(); // Refresh the note list
  }

  void openNotePage(BuildContext context, Map<String, dynamic> note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailNotePage(note: note, onUpdate: fetchNotes),
      ),
    );
  }

  void logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Notes App',
          style: whiteColorTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: whiteColor,
            ),
            onPressed: logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: notes.isEmpty
            ? Center(
                child: Text(
                  'Belum ada note',
                  style: blackColorTextStyle,
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Menampilkan 2 item per baris
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => openNotePage(context, notes[index]),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notes[index]['title'],
                              style: blackColorTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notes[index]['content'],
                              style: blackColorTextStyle.copyWith(
                                fontSize: 12,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => openAddNotePage(context),
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
