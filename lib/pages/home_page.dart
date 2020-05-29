import 'package:agora_live_interactive_broadcasting/pages/audience.dart';
import 'package:agora_live_interactive_broadcasting/pages/broadcaster.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum UserRoles {Audience,Broadcaster}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _username = TextEditingController();
  final _channelName = TextEditingController();
  bool _isBroadcaster = false;
  String check = ''; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 6, 5, 1),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset('assets/logo.png',scale: 2.5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height* 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextFormField(
                            controller: _username,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(45, 156, 215, 1)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(45, 156, 215, 1)
                                )
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                          ),
                          TextFormField(
                            controller: _channelName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(45, 156, 215, 1)
                                )
                              ),  
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(45, 156, 215, 1)
                                )
                              ),
                              hintText: 'Channel Name',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width* 0.65,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SwitchListTile(
                        title: _isBroadcaster? Text('Broadcaster'): Text('Audience'),
                        value: _isBroadcaster,
                        activeColor: Color.fromRGBO(45, 156, 215, 1),
                        secondary: _isBroadcaster? Icon(Icons.account_circle, color: Color.fromRGBO(45, 156, 215, 1),): Icon(Icons.account_circle),
                        onChanged: (value){
                          setState(() {
                            _isBroadcaster = value;
                            print(_isBroadcaster);
                          });
                        }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(45, 156, 215, 1),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: MaterialButton(
                          onPressed: onJoin,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Join ', style: TextStyle(color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 20),),
                              Icon(Icons.arrow_forward, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(check, style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      
    );
  }
  Future<void> onJoin() async{
     if (_username.text.isEmpty || _channelName.text.isEmpty) {
       setState(() {
         check = 'Username and Channel Name are required fields';
       });
     }
     else{
       setState(() {
         check = '';
       });
       if (_isBroadcaster) {
        await PermissionHandler().requestPermissions([PermissionGroup.camera,PermissionGroup.microphone]);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BroadcasterWindow(_channelName.text)));  
       } else {
         await PermissionHandler().requestPermissions([PermissionGroup.camera,PermissionGroup.microphone]);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>AudienceWindow(_channelName.text)));
       }
       
     }
  }
}