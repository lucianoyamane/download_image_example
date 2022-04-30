import 'dart:io';

import 'package:download_image_example/bloc/download_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class CodeCard extends StatefulWidget {
  const CodeCard({Key? key}) : super(key: key);

  @override
  _CodeCardState createState() => _CodeCardState();
}

class _CodeCardState extends State<CodeCard> {
  final TextEditingController _idController = TextEditingController();

  Future<String> getFilePath(uniqueFileName) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$uniqueFileName';
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Row(
          children: [
            Flexible(
              child: TextField(
                controller: _idController,
                decoration: const InputDecoration(hintText: 'Enter card code'),
              ),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(onPressed: ()  async{
              String codeCard = _idController.text.toUpperCase();
              String imageUrl = 'https://deckofcardsapi.com/static/img/$codeCard.png';
              String imagePath = await getFilePath('$codeCard.png');
              BlocProvider.of<DownloadImageBloc>(context).add(DownloadImageEvent(imageUrl, imagePath));
            }, child: const Text('Download'))

          ],
        ),
      ),
    );
  }
}