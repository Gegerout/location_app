class ImageLocationModel {
  final String instagramLocation;
  final String loadedLocation;
  final double latitude;
  final double longitude;

  ImageLocationModel(this.instagramLocation, this.loadedLocation, this.latitude, this.longitude);

  factory ImageLocationModel.formJson(Map<String, dynamic> json) {
    return ImageLocationModel(json["inst_loc"], json["load_loc"], json["lat"], json["lng"]);
  }

  Map<String, dynamic> toJson() => {
    "inst_loc": instagramLocation,
    "load_loc": loadedLocation,
    "lat": latitude,
    "lng": longitude
  };
}