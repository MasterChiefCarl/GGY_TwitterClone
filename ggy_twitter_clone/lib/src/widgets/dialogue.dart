
import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/service_locators.dart';
import 'package:ggy_twitter_clone/src/controllers/auth_controllers.dart';
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
                  maxLines: 1,
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
class UsernameEditingDialog extends StatefulWidget {
  final String uid;
  const UsernameEditingDialog({required this.uid, Key? key}) : super(key: key);
  @override
  State<UsernameEditingDialog> createState() => _UsernameEditingDialogState();
}
class _UsernameEditingDialogState extends State<UsernameEditingDialog> {
  final AuthController _auth = locator<AuthController>();
  late TextEditingController tCon;
  @override
  initState() {
    tCon = TextEditingController(text: "" );
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
                  child: const Text('Edit username'),
                )),
            Flexible(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                child: TextFormField(
                  maxLines: 1,
                  onFieldSubmitted: (String text) {
                    _auth.updateUsername(uid: widget.uid, newUsername: text);
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
                    _auth.updateUsername(uid: widget.uid, newUsername: tCon.text.trim());
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
class HandleNameEditingDialog extends StatefulWidget {
  final String uid;
  const HandleNameEditingDialog({required this.uid, Key? key}) : super(key: key);
  @override
  State<HandleNameEditingDialog> createState() => _HandleNameEditingDialogState();
}
class _HandleNameEditingDialogState extends State<HandleNameEditingDialog> {
  final AuthController _auth = locator<AuthController>();
  late TextEditingController tCon;
  @override
  initState() {
    tCon = TextEditingController(text: "" );
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
                  child: const Text('Edit Handle Name'),
                )),
            Flexible(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                child: TextFormField(
                  maxLines: 1,
                  onFieldSubmitted: (String text) async{
                     await _auth.updateHandle(uid: widget.uid, newHandle: text);
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
                onTap: () async {
                    await _auth.updateHandle(uid: widget.uid, newHandle:tCon.text.trim());
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