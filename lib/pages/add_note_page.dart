import 'package:flutter/material.dart';
import 'package:intermediate_mobile_amcc24/shared/themes/theme.dart';

class AddNotePage extends StatelessWidget {
  final Function(String, String) onSave;

  const AddNotePage({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Tambah Catatan',
          style: whiteColorTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
                labelStyle: blackColorTextStyle.copyWith(
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Note',
                labelStyle: blackColorTextStyle.copyWith(
                  fontWeight: FontWeight.w100,
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () {
                onSave(titleController.text, contentController.text);
              },
              child: Text(
                'Simpan',
                style: whiteColorTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
