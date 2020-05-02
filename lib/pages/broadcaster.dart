import 'package:agora_live_interactive_broadcasting/widgets/broadcasting_status.dart';
import 'package:agora_live_interactive_broadcasting/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BroadcasterWindow extends StatefulWidget {
  @override
  _BroadcasterWindowState createState() => _BroadcasterWindowState();
}

class _BroadcasterWindowState extends State<BroadcasterWindow> {
  
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/broadcast_sample.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Broadcaster'),
      // ),
      body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.9, -0.8),
              child: BroadcastingStatus(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CommentBar(),
              ),
            ),
          ],
        ),
    );
  }
}