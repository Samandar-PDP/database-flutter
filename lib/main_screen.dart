import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_update_screen.dart';
import 'db/sql_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Map<String, dynamic>> _noteList = [];

  @override
  void initState() {
    super.initState();
    _readNoteList();
  }

  void _readNoteList() async {
    _noteList = await SqlHelper.getNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: _noteList.isEmpty ? const Center(
        child: Icon(Icons.hourglass_empty,size: 150,),
      ) : ListView.builder(
        itemCount: _noteList.length,
        itemBuilder: (context, index) {
          final title = _noteList[index]['title'];
          final desc = _noteList[index]['desc'];
          return ListTile(
            leading: Text((index + 1).toString(),style: TextStyle(fontSize: 24),),
            title: Text(title,style: TextStyle(fontSize: 25)),
            subtitle: Text(desc,maxLines: 3,overflow: TextOverflow.ellipsis,),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete,color: Colors.red,),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigate,
        child: const Icon(Icons.add),
      ),
    );
  }
  void _navigate() {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const AddUpdateScreen()));
  }
}
