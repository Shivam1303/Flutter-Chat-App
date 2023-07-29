import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatCard extends StatefulWidget {
  final ChatUser user;
  const ChatCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 5, 3),
      child: Card(
        color: Color(0XFFFFFFFF),
        // shape: RoundedRectangleBorder(
        //   side: BorderSide(
        //     color: Colors.grey.shade200,
        //     width: 0,
        //   ),
        //   borderRadius: BorderRadius.circular(5),
        // ),
        margin: EdgeInsets.symmetric(horizontal: 0.4, vertical: 1),
        elevation: 0.5,
        child: InkWell(
          onTap: () {},
          child: ListTile(
            // leading: const CircleAvatar(child: Icon(Icons.person)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.5),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.height * 0.05,
                height: MediaQuery.of(context).size.height * 0.05,
                imageUrl: widget.user.image,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(Icons.person)),
              ),
            ),
            title: Text(widget.user.name,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            subtitle: Text(widget.user.about,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
            trailing: Text(
              'Time',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
