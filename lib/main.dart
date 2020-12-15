import 'package:flutter/material.dart';
import 'package:flutter_toggly/services/connectivity.dart';
import 'package:flutter_toggly/services/router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:io' as io;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  }
  var appDirectory = (await getApplicationDocumentsDirectory()).path;
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  String localPath = io.Directory("/storage/emulated/0/Android/data/com.interestingtitle.toggly/files").path;
  print(localPath);
  final savedDir = Directory(localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInternetOn = false;
  void initState(){
    super.initState();
    connectivityDataGetter();
    listenConnection();

  }



  @override
  Widget build(BuildContext context) {
    Widget retryConnection = FlatButton(
      child: Text("Tekrar Dene"),
      onPressed:  () {
        connectivityDataGetter();
      },
    );
    Widget quitApp = FlatButton(
      child: Text("Çıkış"),
      onPressed:  () {
        exit(0);
      },
    );
    AlertDialog buildAlertDialog(){
      return AlertDialog(
        title: Text("Lütfen İnternete Bağlanın"),
        content: Text("Bağlantı Kurulamadı."),
        actions: [
          retryConnection,
          quitApp,
        ],
      );
    }
    if(isInternetOn == true){
      return new SplashScreen(
        seconds: 6,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text('', style: TextStyle(color: Colors.black),),
        image: Image.asset('assets/it4.png',width: 137.0, height: 137.0,),
        backgroundColor: Colors.blue[100],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200.0,
        loaderColor: Colors.blue[800],
        loadingText:Text(""),

      );
    }else{
      return buildAlertDialog();

    }
  }


  void connectivityDataGetter() async{
    bool conRes = await getConnectData(context);
    setState(() {
      isInternetOn = conRes;
    });

  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("toggly."),
          automaticallyImplyLeading: false
      ),
      body: new Center(
        child: MaterialApp(
          home: AppRouter(),
        ),

      ),
    );
  }
}
