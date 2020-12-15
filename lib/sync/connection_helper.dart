import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'dart:math';
import 'package:flutter_downloader/flutter_downloader.dart';

var fileLocs = new List<String>();
var files= new List<String>();
String serverIP="192.168.2.128";
String serverPORT="8000";
String name;
String appDirectory;
String fileDirection ;
String directory;
String setIPAdd;
//String tempIP;

List file = new List();
var filo = new File("storage/emulated/0/Android/data/com.interestingtitle.toggly/files/156561.png");
double length = filo.lengthSync().toDouble();
String size = length.toString();
List <String> fileData=new List<String>();
List serverFileData=new List();
List appFileData=new List();
List<String> requestList= new List<String>();
List filesToShow=new List();
String iconName;
String test;
String tempIP="";
String connectedIP;

void requestDownload(String downloadFile) async {
  //establishConnection();
  final taskId =  FlutterDownloader.enqueue(
    //url: "https://duckduckgo.com/i/0227507d.png",
      url: "http://"+serverIP+":"+serverPORT+"/download/"+downloadFile,
      //url: "http://192.168.43.195:8000"+"/download/"+downloadFile,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: '/storage/emulated/0/Android/data/com.interestingtitle.toggly/files',
      fileName: downloadFile,
      showNotification: true,
      openFileFromNotification: true);
  //this function is needed for using flutter downloader plugin
  filesToShow.add(test.toString()+'.png');

}

void dummyDownload() async {

  var rnd = new Random();
  var test=rnd.nextInt(700000)+100000;
  final taskId =  FlutterDownloader.enqueue(
    //url: "http://"+serverIP+":"+serverPORT+"/download/"+"abc.png",
      url: "https://duckduckgo.com/i/0227507d.png",
      //url: "http://"+serverIP+":"+serverPORT+"/download/"+downloadFile,
      //url: "http://192.168.43.195:8000"+"/download/"+downloadFile,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: '/storage/emulated/0/Android/data/com.interestingtitle.toggly/files',
      fileName: test.toString()+'.png',
      showNotification: true,
      openFileFromNotification: true);
  //await _listofFiles();
  //this function is needed for using flutter downloader plugin
  filesToShow.add(test.toString()+'.png');

}
void fileSync() {
  appFileData = io.Directory("/storage/emulated/0/Android/data/com.interestingtitle.toggly/files").listSync();
  serverFileData=serverFileData;
  //print(appFileData);
  //print(serverFileData);
  filesToShow.clear();
  filesToShow.addAll(serverFileData);
  filesToShow.addAll(appFileData);
  //print(filesToShow);

}
Future <void> getServerFileJSONData() async
{
  if(serverIP!=null ) {
    try {
      var conn = await http.get(
          Uri.parse("http://" + serverIP + ":" + serverPORT + "/est_conn"));
      var res = await http.get(
          Uri.parse("http://" + serverIP + ":" + serverPORT + "/get_value"),
          headers: {"Accept": "application/json"});
      var resBody = json.decode(res.body);
      serverFileData = resBody["filedata"] as List;
      print("Getting file list data from server : Done.");
      print("Server Folder File Count:"+serverFileData.length.toString());
    }
    catch(e){
      print("Error: Cannot connect to server.");
      await establishConnection();
    }
  }

}




Future <void> establishConnection() async {
  serverPORT="8000";
  print("Trying to connect server.");
  for (var interface in await NetworkInterface.list()) {
    print('== Interface: ${interface.name} ==');
    for (var addr in interface.addresses) {
      if(interface.name=="wlan0")
        {
          tempIP = addr.address;
        }

      /*print(
          '${addr.address} ${addr.host} ${addr.isLoopback} ${addr
              .rawAddress} ${addr.type.name}');
    */
    }

  }
  print(tempIP);
  print("Creating template for connecting...");
  final String ip = tempIP;
  final String subnet = ip.substring(0, ip.lastIndexOf('.'));
  final int port = 8000;
  final stream2 = NetworkAnalyzer.discover2(subnet, port);
  print("Connected by: "+ip);
  var _IPSplitList=ip.split(".");
  print(_IPSplitList);
  setIPAdd=_IPSplitList[0]+'.'+_IPSplitList[1]+'.'+_IPSplitList[2]+".";
  print("Created template: "+setIPAdd);
  int found = 0;
  stream2.listen((NetworkAddress addr) {
    //print('${addr.ip}:$port');
    if (addr.exists) {
      found++;
      print('Found Server IP: ${addr.ip}:$port');
      connectedIP=addr.ip.toString();
      serverIP=addr.ip.toString();
      serverPORT=port.toString();
      return;
    }
  });

}


IconData getIcon(String x, int y){
  //this function returns us an icon related with the file's type
  x = files[y].substring(files[y].length - 4);
  if(x == ".png"){

    IconData iconName = Icons.image;
    return iconName;
  }
  if(x == ".mp3"){

    IconData iconName = Icons.music_note;
    return iconName;
  }
  if(x == ".mp4"){

    IconData iconName = Icons.video_library;
    return iconName;
  }
  if(x == ".jpeg"){

    IconData iconName = Icons.image;
    return iconName;
  }
  if(x == ".zip"){

    IconData iconName = Icons.archive;
    return iconName;
  }
  if(x == ".jpg"){

    IconData iconName = Icons.image;
    return iconName;
  }
}