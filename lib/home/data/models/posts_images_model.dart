class PostsImagesModel {
  final String mediaUrl;

  PostsImagesModel(this.mediaUrl);

  factory PostsImagesModel.fromJson(Map<String, dynamic> json) {
    return PostsImagesModel(json["media_url"]);
  }

  Map<String, dynamic> toJson() => {
    "media_url": mediaUrl
  };
}