abstract class DownloadImageState {
  final String state;

  DownloadImageState(this.state);

  getState() {
    return state;
  }
}

class DownloadImageInitial extends DownloadImageState {
  DownloadImageInitial() : super('initial');
}

class DownloadImageLoading extends DownloadImageState {
  DownloadImageLoading() : super('loading');
}

class DownloadImageLoaded extends DownloadImageState {
  String savePath;
  DownloadImageLoaded(this.savePath) : super('loaded');
}