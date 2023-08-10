class PostsImagesModel {
  final String mediaUrl;
  final String id;
  final String? caption;
  final String permalink;

  PostsImagesModel(this.mediaUrl, this.id, this.caption, this.permalink);

  factory PostsImagesModel.fromJson(Map<String, dynamic> json) {
    return PostsImagesModel(json["media_url"], json["id"], json["caption"], json["permalink"]);
  }

  Map<String, dynamic> toJson() => {
    "media_url": mediaUrl,
    "id": id,
    "caption": caption,
    "permalink": permalink
  };
}