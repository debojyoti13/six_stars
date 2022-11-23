import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_new_app/fillers/posts.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,
            maxLines: 4,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusColor: Colors.black,
              hintText: "What's on your mind?",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.image,
                color: CupertinoColors.activeBlue,
              ),
              SizedBox(
                width: 4,
              ),
              Icon(Icons.tag),
              SizedBox(
                width: 4,
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
          Row(
              children: <Widget>[
                Expanded(
                    child: Divider()
                ),

                Text(" What is up? ",style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),

                Expanded(
                    child: Divider()
                ),
              ]
          ),
          Posts(),
    ],
      ),
    );
  }
}
