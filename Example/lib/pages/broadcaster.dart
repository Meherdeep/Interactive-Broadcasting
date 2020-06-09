import 'package:agora_live_interactive_broadcasting/widgets/broadcaster_view.dart';
import 'package:agora_live_interactive_broadcasting/widgets/broadcasting_status.dart';
import 'package:agora_live_interactive_broadcasting/widgets/rtm.dart';
import 'package:flutter/material.dart';

class BroadcasterWindow extends StatefulWidget {
  final String channelName;
  final String userName;
  BroadcasterWindow(this.channelName, this.userName);
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
                child: RealTimeMessaging(widget.channelName, widget.userName),
              ),
            ),
          ],
        ),
    );
  }
}