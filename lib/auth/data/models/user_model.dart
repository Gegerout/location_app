class UserModel {
  final int userId;
  final String accessToken;
  final int expiresIn;
  final String createdAt;

  UserModel(this.userId, this.accessToken, this.expiresIn, this.createdAt);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json["user_id"], json["access_token"], json["expires_in"], json["created_at"]);
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "access_token": accessToken,
    "expires_in": expiresIn,
    "created_at": createdAt
  };
}