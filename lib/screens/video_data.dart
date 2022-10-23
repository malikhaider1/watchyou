enum VideoType {
  network,
}

class VideoData {
  final String path;
  final VideoType type;

  VideoData({
    required this.path,
    required this.type,
  });
}