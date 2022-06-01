import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/service_locators.dart';
import 'package:ggy_twitter_clone/src/controllers/auth_controllers.dart';
import 'package:ggy_twitter_clone/src/controllers/chat_controller.dart';
import 'package:ggy_twitter_clone/src/models/chat_message_model.dart';
import 'package:ggy_twitter_clone/src/models/chat_user_model.dart';
import 'package:ggy_twitter_clone/src/services/image_service.dart';
import 'package:ggy_twitter_clone/src/widgets/avatars.dart';
import 'package:ggy_twitter_clone/src/widgets/chat_card.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _auth = locator<AuthController>();
  final ChatController _chatController = ChatController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFN = FocusNode();
  final ScrollController _scrollController = ScrollController();

  ChatUser? user;

  @override
  void initState() {
    ChatUser.fromUid(uid: FirebaseAuth.instance.currentUser!.uid).then((value) {
      if (mounted) {
        setState(() {
          user = value;
        });
      }
    });
    _chatController.addListener(scrollToBottom);
    super.initState();
  }

  scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 250));
    print('scrolling to bottom');
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _chatController.removeListener(scrollToBottom);
    _messageFN.dispose();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(user != null ? "Welcome ${user!.username}" : '. . .',style: Theme.of(context).textTheme.headline1,),
        actions: [
          Builder(builder: (context) {
            // return IconButton(
            //   onPressed: () async {
            //     Scaffold.of(context).openEndDrawer();
            //   },
            //   icon: const Icon(Icons.menu),
            // );
            return TextButton(
              onPressed: () async {
                Scaffold.of(context).openEndDrawer();
              },
              child: AvatarImage(
                  uid: FirebaseAuth.instance.currentUser!.uid, radius: 20),
            );
          }),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DrawerHeader(
              child: Stack(
                fit: StackFit.expand,
                children: [
                Container(
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    height: double.infinity),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        ImageService.updateProfileImage();
                      },
                      child: AvatarImage(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        radius: 40,
                      ),
                    ),
                    const SizedBox(
                      // width: double.infinity,
                      width: 15,
                      height: 15,
                    ),
                    UserNameFromDB(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        fontSize: 25)
                  ],
                ),
              ]),
            ),
            Expanded(
              child: Column(
                children: const [
                  Text('Content'),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text('Log out'),
              onTap: () async {
                _auth.logout();
              },
            )
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                  animation: _chatController,
                  builder: (context, Widget? w) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      controller: _scrollController,
                      child: Column(
                        children: [
                          for (ChatMessage chat in _chatController.chats)
                            ChatCard(chat: chat)
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onEditingComplete: send,
                      onFieldSubmitted: (String text) {
                        send();
                      },
                      focusNode: _messageFN,
                      controller: _messageController,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Input Message Here',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(8),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                    ),
                    onPressed: send,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  send() {
    _messageFN.unfocus();
    if (_messageController.text.isNotEmpty) {
      _chatController.sendMessage(message: _messageController.text.trim());
      _messageController.text = '';
    }
  }
}
