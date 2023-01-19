import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disko_001/models/chat_message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage(
      {Key? key,
      required this.collectionPath,
      required this.chatName,
      required this.receiverUid})
      : super(key: key);
  final String collectionPath, chatName, receiverUid;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  var _userEnterMessage = '';
  Future<void> _sendMessage() async {
    controller.clear();
    final messageData = ChatMessageModel(
      time: Timestamp.now(),
      senderId: user!.uid,
      receiverUid: widget.receiverUid,
      message: _userEnterMessage,
    ).toJson();
    FirebaseFirestore.instance
        .collection(widget.collectionPath)
        .add(messageData);

    final currentChat =
        FirebaseFirestore.instance.collection('messages').doc(widget.chatName);
    final doc = await currentChat.get();
    (doc.exists)
        ? currentChat.update(messageData)
        : currentChat.set(messageData);
    await currentChat.update({"unreadMessageCount": FieldValue.increment(1)});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              // suffixIcon: Container(
              //   padding: const EdgeInsets.all(0.0),
              //   width: 24,
              //   child: IconButton(
              //     constraints: const BoxConstraints(),
              //     padding: EdgeInsets.zero,
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.emoji_emotions_outlined,
              //     ),
              //   ),
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              hintText: "메세지 보내기",
            ),
            onChanged: (value) {
              setState(() {
                _userEnterMessage = value;
              });
            },
          ),
        ),
        IconButton(
          onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
          icon: Icon(
            Icons.send,
            color: _userEnterMessage.trim().isEmpty
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
