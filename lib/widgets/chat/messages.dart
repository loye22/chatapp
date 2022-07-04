// import 'package:chat_app_with_firebasee2/widgets/chat/message_bubble.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//
// class maseeges extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('chatss')
//             .orderBy('date', descending: true)
//             .snapshots(),
//         builder: (ctx, AsyncSnapshot<QuerySnapshot> snap) {
//           if (!snap.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snap.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//               reverse: true,
//               itemBuilder: (ctx, i) => msgBubble(
//                   msg: snap.data.docs[i]['text'],
//                   isMe: snap.data.docs[i]['userId'] ==),
//               itemCount: snap.data.docs.length);
//         });
//   }
// }
//

import 'package:chat_app_with_firebasee2/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class maseeges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future<User>.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, Fsnap) => StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chatss')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //   print(Fsnap.data.uid);
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, i) =>
                    msgBubble(
                    msg: snap.data.docs[i]['text'],
                    isMe: snap.data.docs[i]['userId'] == Fsnap.data.uid ,
                    key:ValueKey(snap.data.docs[i].id) ,
                    username: snap.data.docs[i]['userName'],
                    imageUrl: snap.data.docs[i]['userImage']),
                itemCount: snap.data.docs.length);
          }),
    );
  }
}
