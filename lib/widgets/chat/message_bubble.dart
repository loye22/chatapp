import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class msgBubble extends StatelessWidget {
//  const msgBubble({Key? key}) : super(key: key);
  final String msg;
  final Key key;
  final username;
  final String imageUrl;
  final bool isMe;

  msgBubble({this.msg, this.isMe, this.imageUrl, this.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            //    bottomRight:Radius.circular(20) ,
                            bottomLeft: Radius.circular(20),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            //   bottomLeft: Radius.circular(20),
                          ),
                    color:
                        isMe ? Colors.grey[400] : Theme.of(context).accentColor),
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(this.username.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe ? Colors.black : Colors.white)),
                    Text(msg,
                        style:
                            TextStyle(color: isMe ? Colors.black : Colors.white)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -8,
              left:isMe ?  10  : 0,
              right: isMe ? null : -120,

              child: Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:NetworkImage(imageUrl) ,



                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
