
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/src/models/chat_message_model.dart';
import 'package:ggy_twitter_clone/src/widgets/avatars.dart';
import 'package:ggy_twitter_clone/src/widgets/edit_dialogue.dart';
import 'package:simple_moment/simple_moment.dart';
class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final ChatMessage chat;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Moment.fromDateTime(chat.ts.toDate()).format('MMMM dd,yyyy hh:mm aa'),
          style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
        ),
        Row(
          children: [
            if (chat.sentBy == FirebaseAuth.instance.currentUser!.uid)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment:
                          chat.sentBy != FirebaseAuth.instance.currentUser!.uid
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        if (chat.sentBy !=
                            FirebaseAuth.instance.currentUser?.uid)
                          AvatarImage(
                            uid: chat.sentBy,
                            radius: 12,
                          ),
                        if (chat.sentBy !=
                            FirebaseAuth.instance.currentUser?.uid)
                          const SizedBox(
                            width: 8,
                          ),
                        if (chat.sentBy ==
                            FirebaseAuth.instance.currentUser?.uid)
                          const Text('You')
                        else
                          UserNameFromDB(uid: chat.sentBy),
                      ],
                    ),
                  ),
                  InkWell(
                    onLongPress: chat.sentBy ==
                                FirebaseAuth.instance.currentUser!.uid &&
                            chat.message != '[Message has been removed by user]'
                        ? () {
                            showDialog(
                                context: context,
                                builder: (dCon) {
                                  return ChatEditingDialog(chat: chat);
                                });
                          }
                        : () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: chat.sentBy ==
                                FirebaseAuth.instance.currentUser!.uid
                                // ?Colors.orange:Colors.white,
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onBackground,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: chat.sentBy ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? const Offset(3, 3)
                                : const Offset(
                                    -3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: chat.sentBy ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.message,
                            textAlign: chat.sentBy ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Seen by',
                            style: TextStyle(fontSize: 10),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: chat.sentBy ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              for (String user in chat.seenBy)
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: AvatarImage(
                                      uid: user,
                                      radius: 8,
                                    ))
                              // for (int i = 0; i < chat.seenBy.length; i++)
                              //   if (chat.seenBy[i] ==
                              //       FirebaseAuth.instance.currentUser!.uid)
                              //     Text(
                              //       'You${i != chat.seenBy.length - 1 ? ', ' : ''}',
                              //       style: const TextStyle(fontSize: 10),
                              //     )
                              //   else
                              //     FutureBuilder(
                              //         future:
                              //             ChatUser.fromUid(uid: chat.seenBy[i]),
                              //         builder: (context,
                              //             AsyncSnapshot<ChatUser> snap) {
                              //           if (snap.hasData) {
                              //             return Text(
                              //               '${snap.data?.username}${i != chat.seenBy.length - 1 ? ', ' : ''}',
                              //               style: const TextStyle(fontSize: 10),
                              //             );
                              //           }
                              //           return const Text('');
                              //         }),
                            ],
                          ),
                          if (chat.sentBy ==
                              FirebaseAuth.instance.currentUser!.uid)
                            const SizedBox(
                              height: 8,
                            ),
                          if (chat.sentBy ==
                                  FirebaseAuth.instance.currentUser!.uid &&
                              chat.message !=
                                  '[Message has been removed by user]')
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 4,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     showDialog(
                                //         context: context,
                                //         builder: (dCon) {
                                //           return ChatEditingDialog(chat: chat);
                                //         });
                                //   },
                                //   child: const Icon(
                                //     Icons.edit,
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (dCon) {
                                          return ChatEditingDialog(chat: chat);
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children:  [
                                        Text(
                                          'Edit',
                                          style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.onError),
                                        ),
                                        const Icon(
                                          Icons.edit,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    chat.deleteMessage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children:  [
                                        Text(
                                          'Delete',
                                          style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.onError),
                                        ),
                                        const Icon(
                                          Icons.delete,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (chat.sentBy != FirebaseAuth.instance.currentUser!.uid)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
          ],
        ),
      ],
    );
  }
}
