import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String UserName;
  final String UserId;

  ChatScreen({super.key, required this.UserName, required this.UserId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();
  final chatref = FirebaseDatabase.instance.ref().child("chats");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrlKnpOmtCR3Tv8f--w8hJw2GovcriYgHZsA&s"),
        title: Center(child: Text("New Users")),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: getMsg(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data?.snapshot.children.toList();
                    return data?.isNotEmpty != null
                        ? ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              var msg = data?[index].value as Map;
                              var id = data[index].key;
                              var userId = msg['userId'];
                              return userId == widget.UserId
                                  ? InkWell(
                                      onLongPress: () {
                                        deleteMsg(id!);
                                        setState(() {

                                        });
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: messageView(msg),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.bottomLeft,
                                      child: messageView(msg),
                                    );
                            },
                          )
                        : Center(
                            child: Text("No msg"),
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: msgController,
                  decoration: InputDecoration(
                    hintText: "send message",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                      // borderSide: BorderSide(color: Colors.black45)
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CircleAvatar(
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    addMassage(msgController.text.trim());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget messageView(Map<dynamic, dynamic> message) {
    return InkWell(
      onLongPress: () => deleteMsg(message['id']),
      // Check if 'id' is the correct key in your Firebase data
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message['name'].toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(message['message'].toString()),
              Text(
                message['date'].toString(),
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addMassage(String msg) async {
    var chatref = FirebaseDatabase.instance.ref("chats");
    var id = chatref.push().key;
    await chatref.child(id.toString()).set({
      "message": msg,
      "name": widget.UserName,
      "date": DateTime.now().toString()
    }).then((value) {
      msgController.clear();
    });
  }

  Stream<DatabaseEvent> getMsg() {
    var realtime = FirebaseDatabase.instance.ref("chats");
    return realtime.onValue;
  }

  deleteMsg(String messageId) async {
    await chatref.remove();
  }
}
