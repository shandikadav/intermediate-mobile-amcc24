import 'package:flutter/material.dart';
import 'package:intermediate_mobile_amcc24/shared/themes/theme.dart';

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
        backgroundColor: primaryColor,
        title: Text(
          'Edit Note',
          style: whiteColorTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: whiteColor,
            ),
            onPressed: () {
              // Logic to update note in Firestore
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              // Konfirmasi sebelum menghapus
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
