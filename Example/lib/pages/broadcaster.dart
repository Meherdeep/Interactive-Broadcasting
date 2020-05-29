import 'package:agora_live_interactive_broadcasting/widgets/broadcaster_view.dart';
import 'package:agora_live_interactive_broadcasting/widgets/broadcasting_status.dart';
import 'package:agora_live_interactive_broadcasting/widgets/comment.dart';
import 'package:agora_live_interactive_broadcasting/widgets/rtm.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BroadcasterWindow extends StatefulWidget {
  final String channelName;
  BroadcasterWindow(this.channelName);
  @override
  _BroadcasterWindowState createState() => _BroadcasterWindowState();
}

class _BroadcasterWindowState extends State<BroadcasterWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: BroadcasterView(widget.channelName),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.9, -0.8),
              child: BroadcastingStatus('69'.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RealTimeMessaging(widget.channelName),
              ),
            ),
          ],
        ),
    );
  }
}