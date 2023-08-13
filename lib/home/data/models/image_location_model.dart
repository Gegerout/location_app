class ImageLocationModel {
  final String instagramLocation;
  final String loadedLocation;
  final double latitude;
  final double longitude;
  final String permalink;

  ImageLocationModel(this.instagramLocation, this.loadedLocation, this.latitude, this.longitude, this.permalink);

  factory ImageLocationModel.fromJson(Map<String, dynamic> json) {
    return ImageLocationModel(json["inst_loc"], json["load_loc"], json["lat"], json["lng"], json["permalinks"]);
  }

  Map<String, dynamic> toJson() => {
    "inst_loc": instagramLocation,
    "load_loc": loadedLocation,
    "lat": latitude,
    "lng": longitude,
    "permalinks": permalink
  };
}