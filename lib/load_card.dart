import 'dart:io';

import 'package:download_image_example/bloc/download_image_bloc.dart';
import 'package:download_image_example/bloc/download_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadCard extends StatefulWidget {
  const LoadCard({Key? key}) : super(key: key);

  @override
  _LoadCardState createState() => _LoadCardState();
}

class _LoadCardState extends State<LoadCard> {


  @override
  Widget build(BuildContext context) {
    return Center(child:
    SizedBox(
        height: 250,
        width: 250,
        child: BlocBuilder<DownloadImageBloc, DownloadImageState> (
            builder: (context, state) {
              if (state.getState() == 'loaded') {
                DownloadImageLoaded stateLoaded = state as DownloadImageLoaded;
                return Center(
                  child: Image.file(
                        File(stateLoaded.savePath),
                        height: 200,
                  ),
                );
              }
              if (state.getState() == 'loading') {
                return Card(
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
                );
              }
              return const Center(child: Text('no card'),);

            })
      ),
    );
  }
}