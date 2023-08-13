class ImageLocationModel {
  final String instagramLocation;
  final String loadedLocation;
  final double latitude;
  final double longitude;
  final String mediaUrl;

  ImageLocationModel(this.instagramLocation, this.loadedLocation, this.latitude, this.longitude, this.mediaUrl);

  factory ImageLocationModel.fromJson(Map<String, dynamic> json) {
    return ImageLocationModel(json["inst_loc"], json["load_loc"], json["lat"], json["lng"], json["media_url"]);
  }

  Map<String, dynamic> toJson() => {
    "inst_loc": instagramLocation,
    "load_loc": loadedLocation,
    "lat": latitude,
    "lng": longitude,
    "media_url": mediaUrl
  };
}