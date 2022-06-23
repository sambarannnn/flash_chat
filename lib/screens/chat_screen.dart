import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String? messageText;

  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  //Implement logout functionality
                  messagesStream();
                  // _auth.signOut();
                  // Navigator.pop(context);
                }),
          ],
          title: Text('⚡ Flash️Chat'),
          backgroundColor: kInactiveCardColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(child: MessagesStream()),
            Container(
              height: 75,
              // margin: EdgeInsets.only(bottom: 5),
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      if (messageText != null) {
                        // print(messageText);
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email
                        });
                        messageTextController.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Send  ',
                          style: kSendButtonTextStyle,
                        ),
                        Icon(
                          Icons.send_rounded,
                          color: kLogoBright,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> MessageBubbles = [];
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          final currentUser = loggedInUser.email;
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            bool isMe = false;
            if (currentUser == messageSender) {
              isMe = true;
            }
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: isMe,
            );

            //add this Widget to our Widget list
            MessageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: MessageBubbles,
            ),
          );
        } else {
          return Container(
            child: LinearProgressIndicator(
              color: kLogoBright,
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  MessageBubble({required this.sender, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isMe ? '' : sender,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 3, 3),
            child: Material(
              borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(30),
              ),
              shadowColor: isMe ? kLogoBright : kReceiverColor,
              elevation: 5,
              color: isMe ? kLightBtn : kLogoBright,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  '$text',
                  style: TextStyle(color: Colors.white, fontSize: 15, shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 17),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
