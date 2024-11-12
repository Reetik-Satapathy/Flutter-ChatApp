import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
class Chat extends StatefulWidget {
  const Chat({super.key});
 
  @override
  State<Chat> createState() => _ChatState();
}
 
class _ChatState extends State<Chat> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> responses = [];
 
  void sendMessage() async {
    Uri url = Uri.parse("https://sugoi-api.vercel.app/chat?msg=" + controller.text);
 
    http.Response response = await http.get(url);
    dynamic data = json.decode(response.body);
 
    setState(() {
      responses.add({
        "msg": data["msg"],
        "response": data["response"]
      });
    });
 
    controller.clear();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Chat"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  responses.clear();
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
      backgroundColor: Colors.blueGrey[800],
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: responses.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80),
                          child: ListTile(
                            title: Text(
                              responses[index]["msg"]!,
                              textAlign: TextAlign.right,
                            ),
                            tileColor: Color.fromRGBO(255, 255, 255, 0.4),
                            trailing: Icon(Icons.person),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    bottomLeft: Radius.circular(32))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: ListTile(
                            leading: Icon(
                              Icons.computer,
                              color: Colors.white,
                            ),
                            title: Text(
                              responses[index]["response"]!,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white),
                            ),
                            tileColor: Color.fromRGBO(4, 90, 119, 1.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            )),
                          ),
                        )
                      ],
                    );
                  })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                    width: 330,
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.blue[800],
                          filled: true,
                          hintText: "Enter a message",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(32)),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      size: 28,
                    ),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
