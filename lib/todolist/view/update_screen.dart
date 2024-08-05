import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> task;

  UpdateScreen({required this.index, required this.task});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task['title'] ?? '';
    _descriptionController.text = widget.task['description'] ?? '';
    _imagePath = widget.task['image'];
  }

  Future<void> _updateTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasksData = prefs.getStringList('tasks');

    if (tasksData != null) {
      List<Map<String, dynamic>> tasks = tasksData.map((task) {
        return Map<String, dynamic>.from(json.decode(task));
      }).toList();

      tasks[widget.index] = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'image': _imagePath,
        'isComplete': widget.task['isComplete'] ?? false,
      };

      prefs.setStringList('tasks', tasks.map((task) => json.encode(task)).toList());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task' ,
          style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Color(0xFF436878),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (_imagePath != null)
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(File(_imagePath!)),
                ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                color: Color(0xFF436878),
                minWidth: 378,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: _updateTask,
                child: Text(
                  'Update Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
