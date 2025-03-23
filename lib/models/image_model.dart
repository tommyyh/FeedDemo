class ImageModel {
  final String url;

  ImageModel({required this.url});

  factory ImageModel.fromJson(String data) {
    return ImageModel(url: data);
  }
}
