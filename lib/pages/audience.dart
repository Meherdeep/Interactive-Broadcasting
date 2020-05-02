import 'package:flutter/material.dart';

class AudienceWindow extends StatefulWidget {
  @override
  _AudienceWindowState createState() => _AudienceWindowState();
}

class _AudienceWindowState extends State<AudienceWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audience'),
      ),
    );
  }
}