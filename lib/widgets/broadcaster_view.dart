import 'package:agora_live_interactive_broadcasting/utils/app_id.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class BroadcasterView extends StatefulWidget {
  final String channelName;
  BroadcasterView(this.channelName);
  @override
  _BroadcasterViewState createState() => _BroadcasterViewState();
}

class _BroadcasterViewState extends State<BroadcasterView> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  int broadcasterUid = 0;
  int _viewId;

  @override
  void initState() { 
    super.initState();
    initialize();
  }

  @override
  void dispose(){
    super.dispose();
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    AgoraRtcEngine.removeNativeView(_viewId);
  }

  Future<void> initialize() async {
    if(appID.isEmpty){
      setState(() {
        _infoStrings.add('APP Id is miising');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');

  }

  Future<void> _initAgoraRtcEngine() async{
    await AgoraRtcEngine.create(appID);
    await AgoraRtcEngine.enableVideo();
    await AgoraRtcEngine.muteLocalVideoStream(true);
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(ClientRole.Audience);
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, broadcasterUid );
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code){
      setState(() {
        _infoStrings.add('onError : $code');
      });
    };
    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ){
      broadcasterUid = uid;
      setState(() {
      _infoStrings.add('onJoinChannel: $channel, uid: $uid');
      });
    };
    AgoraRtcEngine.onUserJoined = (int uid, int elapsed){
      setState(() {
        _infoStrings.add('userJoined: $uid');
        _users.add(uid);
      });
    };
    AgoraRtcEngine.onLeaveChannel = (){
      setState(() {
        _infoStrings.add('Viewer left');
      });
    };
    print(_infoStrings);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AgoraRtcEngine.createNativeView((viewId){
        _viewId = viewId;
        AgoraRtcEngine.joinChannel(null, widget.channelName, null, broadcasterUid);
        AgoraRtcEngine.startPreview();
        AgoraRtcEngine.enableVideo();
        AgoraRtcEngine.setupLocalVideo(_viewId, VideoRenderMode.Fit);
      }),
    );
  }
}