
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_toggly/sync/connection_helper.dart';
import 'dart:io' as io;
launchURL() async {
  const url = 'https://github.com/interestingtitle';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class ConnectToServer extends StatefulWidget {

  @override
  _ConnectToServerState createState() => _ConnectToServerState();

}

class _ConnectToServerState extends State<ConnectToServer> {

  String IPAddress= "192.168.2.128";

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.blue[50],
      child:ListView(
        padding: new EdgeInsets.all(1.0),
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  "toggly.",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                //if (icon != null)
                // IconTheme(data: Theme.of(context).iconTheme, child: icon),
                Text(
                  "v1.0.0",
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),


          SizedBox(
            height: 60.0,
            child:RaisedButton(
              color:Colors.white,
              onPressed:(){

              },
              child: Text("Trying to establish connection. \n Please set desktop application ready."),
            ),

          ),
          TextFormField(
              initialValue: IPAddress,
              textAlign: TextAlign.center,
              onChanged: (val){
                setState(() {
                  IPAddress = val;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,

            )
          ),



          SizedBox(height: 20.0,),
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: Text(
              "Connect",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onPressed: () async{
              //establishConnection();
              //dummyDownload();
              String localPath = io.Directory("/storage/emulated/0/Android/data/com.interestingtitle.toggly/files").path;
              print(localPath);
              //requestDownload("abc.png");
              //print("->"+IPAddress);
              }
          ),
          SizedBox(
            height: 60.0,
            child:RaisedButton(
              color:Colors.white,
              onPressed:(){
              },

            ),

          ),
          SizedBox(
            height: 60.0,
            child:RaisedButton(
              color:Colors.white,
              onPressed:(){
                launchURL();
              },
              child: Text("2020 © InterestingTitle \ngithub.com/interestingtitle"),
            ),

          ),
        ],
      ),

    );


  }
}

