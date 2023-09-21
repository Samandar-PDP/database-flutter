import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_db/db/sql_helper.dart';
import 'package:sqflite_db/main_screen.dart';

class AddUpdateScreen extends StatefulWidget {
  const AddUpdateScreen({super.key});

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {

  final _title = TextEditingController();
  final _desc = TextEditingController();

  void _saveNote() async {
    await SqlHelper.saveNote(_title.text, _desc.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        actions: [IconButton(onPressed: () {
          if(_title.text.isNotEmpty && _desc.text.isNotEmpty) {
            _saveNote();
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => MainScreen()),
                    (Route<dynamic> route) => false
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter value")));
          }
        }, icon: const Icon(Icons.check))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 40,child: TextField(
              controller: _title,
              style: const TextStyle(fontSize: 25),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                hintText: 'Title',
                hintStyle:  TextStyle(fontSize: 25)
              ),
            )),
            Expanded(child: TextField(
              maxLines: null,
              controller: _desc,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Description'
              ),
            ))
          ],
        ),
      ),
    );
  }
}
