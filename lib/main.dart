import 'dart:io';

import 'package:download_image_example/bloc/download_image_bloc.dart';
import 'package:download_image_example/bloc/download_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

Future<String> getFilePath(uniqueFileName) async {
  Directory dir = await getApplicationDocumentsDirectory();
  return '${dir.path}/$uniqueFileName';
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => DownloadImageBloc(), child: Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocProvider(create: (context) => DownloadImageBloc(),
              child: BlocBuilder<DownloadImageBloc, DownloadImageState>(
                  builder: (context, state) {
                    if (state.getState() == 'loaded') {
                      DownloadImageLoaded stateLoaded = state as DownloadImageLoaded;
                      return Center(child: SizedBox(
                                height: 250,
                                width: 250,
                                child: Center(
                                  child: Image.file(
                                    File(stateLoaded.savePath),
                                    height: 200,
                                  ),
                                ),
                              )
                            );
                    }

                  if (state.getState() == 'loading') {

                    return Center(
                        child: SizedBox(
                            height: 250,
                            width: 250,
                            child: Card(
                              color: Colors.blue.shade50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'downloading',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                        )
                    );
                  }
                  return Center(
                      child: SizedBox(
                                height: 250,
                                width: 250,
                                child: Card(
                                  color: Colors.blue.shade50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                                ElevatedButton(onPressed: ()  async{
                                                            String imageUrl = 'https://deckofcardsapi.com/static/img/AS.png';
                                                            String imagePath = await getFilePath('KH.png');
                                                            BlocProvider.of<DownloadImageBloc>(context).add(DownloadImageEvent(imageUrl, imagePath));
                                                }, child: const Text('Download'))
                                    ],
                                  ),
                                )
                      )
                  );

                  }
                  )
              ),
          ],
        ),
      ),),);
      // floatingActionButton: FloatingActionButton(
      //   onPressed:() async {
      //     String imageUrl = 'https://deckofcardsapi.com/static/img/KH.png';
      //     String imagePath = await getFilePath('my_image');
      //     BlocProvider.of<DownloadImageBloc>(context).add(DownloadImageEvent(imageUrl, imagePath));
      //   },
      //   tooltip: 'Download',
      //   child: const Icon(Icons.download),
      // ),
    // );
  }
}
