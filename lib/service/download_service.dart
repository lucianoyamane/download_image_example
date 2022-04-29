import 'package:download_image_example/api/http_api.dart';

class DownloadService {
  static DownloadService? _instance;

  factory DownloadService() => _instance ??= DownloadService._();

  DownloadService._();

  Future downloadImage(String url, String path ) async {
    await Api().download(url, path);
  }

}