import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailNotePage extends StatelessWidget {
  final Map<String, dynamic> note;
  final Function onUpdate;

  const DetailNotePage({Key? key, required this.note, required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: note['title']);
    final TextEditingController contentController =
        TextEditingController(text: note['content']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Logic to update note in Firestore
              FirebaseFirestore.instance
                  .collection('notes')
                  .doc(note['id'])
                  .update({
                'title': titleController.text,
                'content': contentController.text,
              });
              onUpdate(); // Refresh notes list
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
