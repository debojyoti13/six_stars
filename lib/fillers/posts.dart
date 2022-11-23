import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Flexible(
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 100,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index) {
            return Scaffold(
              body: Card(

                elevation: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            minRadius: 10,
                            maxRadius: 15,
                            child: Icon(
                              Icons.person,
                              size: 25,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                            child: Text(
                          maxLines: 2,
                          "Debojyoti Sarkar the fourth",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            textAlign: TextAlign.justify,
                            maxLines: 6,
                            lorem(words: 100),
                            style: TextStyle(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                      ],
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.thumb_up,color: CupertinoColors.black,size: 10,),
                          Text(" 1.3k  ",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          Icon(Icons.thumb_down,color: CupertinoColors.black,size: 10,),
                          Text(" 9.3k  ",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          Icon(Icons.messenger,color: CupertinoColors.black,size: 10,),
                          Text(" 1k",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
