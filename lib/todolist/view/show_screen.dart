import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'update_screen.dart';
import 'add_screen.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key});

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  List<Map<String, dynamic>> tasks = [];
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = false;
  String _currentLocation = "Location not available";

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _checkConnectivity();
    _getCurrentLocation();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasksData = prefs.getStringList('tasks');

    if (tasksData != null) {
      setState(() {
        tasks = tasksData.map((task) {
          return Map<String, dynamic>.from(json.decode(task));
        }).toList();
      });
    }
  }

  Future<void> _updateTaskStatus(int index, bool isComplete) async {
    setState(() {
      tasks[index]['isComplete'] = isComplete;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksData = tasks.map((task) => json.encode(task)).toList();
    await prefs.setStringList('tasks', tasksData);
  }

  Future<void> _deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksData = tasks.map((task) => json.encode(task)).toList();
    await prefs.setStringList('tasks', tasksData);
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = "Location permissions are denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation = "Location permissions are permanently denied";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];

    setState(() {
      _currentLocation = "${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF436878),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddScreen()),
          ).then((_) => _loadTasks());
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF436878), toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Show Task",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              _currentLocation,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Column(
              children: [
                Icon(Icons.wifi, color: _isConnected ? Colors.green : Colors.red, size: 30),
                Text(
                  _isConnected ? "Connected" : "Disconnected",
                  style: TextStyle(fontSize: 15, color: _isConnected ? Colors.green : Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(
        child: Text(
          'No tasks available',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (task['image'] != null)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(File(task['image']!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  if (task['title'] != null)
                    Text(
                      task['title']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 5),
                  if (task['description'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['description']!,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Location: $_currentLocation',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: task['isComplete'] ?? false,
                            onChanged: (bool? value) {
                              _updateTaskStatus(index, value!);
                            },
                          ),
                          Text(
                            task['isComplete'] ?? false
                                ? 'Complete'
                                : 'Incomplete',
                            style: TextStyle(
                              fontSize: 16,
                              color: task['isComplete'] ?? false
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Delete') {
                            _deleteTask(index);
                          } else if (value == 'Update') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                  index: index,
                                  task: task,
                                ),
                              ),
                            ).then((_) => _loadTasks());
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Delete', 'Update'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
