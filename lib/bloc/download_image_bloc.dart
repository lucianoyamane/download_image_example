import 'package:download_image_example/bloc/download_image_state.dart';
import 'package:download_image_example/service/download_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadImageEvent {
  final String imageUrl;
  final String imagePath;

  DownloadImageEvent(this.imageUrl, this.imagePath);
}

class DownloadImageBloc extends Bloc<DownloadImageEvent, DownloadImageState> {
  DownloadImageBloc() : super(DownloadImageInitial()) {
    final DownloadService _downloadService = DownloadService();
    on<DownloadImageEvent>((event, emit) async{
      emit(DownloadImageLoading());
      await _downloadService.downloadImage(event.imageUrl, event.imagePath);
      emit(DownloadImageLoaded(event.imagePath));
    });
  }
}