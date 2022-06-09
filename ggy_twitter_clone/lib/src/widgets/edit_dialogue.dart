import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/src/models/chat_message_model.dart';

class ChatEditingDialog extends StatefulWidget {
  final ChatMessage chat;
  const ChatEditingDialog({required this.chat, Key? key}) : super(key: key);

  @override
  State<ChatEditingDialog> createState() => _ChatEditingDialogState();
}

class _ChatEditingDialogState extends State<ChatEditingDialog> {
  late TextEditingController tCon;
  @override
  initState() {
    tCon = TextEditingController(text: widget.chat.message);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('Edit message'),
                )),
            Flexible(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                child: TextFormField(
                  maxLines: 5,
                  onFieldSubmitted: (String text) {
                    widget.chat.updateMessage('[edited message] \n$text');
                    Navigator.of(context).pop();
                  },
                  controller: tCon,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 100,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Text('Send'),
                      SizedBox(width: 10),
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  widget.chat.updateMessage('[edited message] \n${tCon.text}');
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
