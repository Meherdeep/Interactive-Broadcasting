import 'package:flutter/material.dart';

class CommentBar extends StatefulWidget {
  @override
  _CommentBarState createState() => _CommentBarState();
}

class _CommentBarState extends State<CommentBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width* 0.8,
                      color: Color.fromRGBO(255, 255, 255, 0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color.fromRGBO(45, 156, 215, 1))
                          ),
                          hintText: 'Comment'
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.white70
                        )
                      ),
                      child: IconButton(icon: Icon(Icons.send, color: Colors.white70,), onPressed: (){}, splashColor: Color.fromRGBO(45, 156, 215, 1),),
                    )

                  ],
                );
  }
}