import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullscreen_image/fullscreen_image.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Fullscreen image example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: SingleChildScrollView(
          child: Container(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),

                Text('Image Assets Popup',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                  ),),
                ImageAssetsFullscreen(
                  imagePath: 'assets/default_image.png',
                  imageBorderRadius: 200,
                  imageWidth: 200,
                  imageHeight: 200,
                  iconBackButtonColor: Colors.red,
                  imageDetailsHeight: 500,
                  imageDetailsWidth: 200,
                  hideBackButtonDetails: true,
                  appBarBackgroundColorDetails: Colors.red,
                  backgroundColorDetails: Colors.green,
                  imageDetailsFit: BoxFit.cover,
                  hideAppBarDetails: true,
                  imageFit: BoxFit.fill,
                  withHeroAnimation: true,
                ),

                Divider(
                  height: 25,
                ),


                Text('Image Network Popup',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                  ),),
                ImageNetworkFullscreen(
                  imageUrl: 'https://picsum.photos/id/1/200/300',
                  imageBorderRadius: 20,
                  imageWidth: 200,
                  imageHeight: 200,
                ),

                Divider(
                  height: 25,
                ),


                Text('Image Cached Popup',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                  ),),
                ImageCachedFullscreen(
                  imageUrl: 'https://picsum.photos/200/300',
                  imageBorderRadius: 20,
                  imageWidth: 200,
                  imageHeight: 200,
                  withHeroAnimation: true,
                  placeholder: Container(
                    child: Icon(Icons.check),
                  ),
                  errorWidget: Container(
                    child: Icon(Icons.error),
                  ),
                ),

                Divider(
                  height: 25,
                ),
                Text('Image Cached Popup with custom options',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                  ),),
                ImageCachedFullscreen(
                  imageUrl: 'https://picsum.phots/200/300',
                  imageBorderRadius: 20,
                  imageWidth: 200,
                  imageHeight: 200,
                  placeholder: Container(
                    child: Icon(Icons.check),
                  ),
                  errorWidget: Container(
                    child: Icon(Icons.error),
                  ),
                  iconBackButtonColor: Colors.red,
                  imageDetailsHeight: 500,
                  imageDetailsWidth: 200,
                  hideBackButtonDetails: true,
                  appBarBackgroundColorDetails: Colors.red,
                  backgroundColorDetails: Colors.green,
                  imageDetailsFit: BoxFit.cover,
                  hideAppBarDetails: true,
                  imageFit: BoxFit.fill,
                  withHeroAnimation: true,
                ),

                SizedBox(height: 20,),




              ],
            ),
          ),
        ),
      ),);
  }
}
