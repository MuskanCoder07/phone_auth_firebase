import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Column(
        children: [
          Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV76yL8Bpsj3M7akd_GcECTnewSUeuzmFBET41k01Q6vreKbcRE0-AUlkmVIdDG1BkXPc&usqp=CAU"
          )
        ],
      ),
    );
  }
}
