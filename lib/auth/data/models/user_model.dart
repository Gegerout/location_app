class UserModel {
  final int userId;
  final String accessToken;
  final int expiresIn;
  final String createdAt;
  final String username;
  final int mediaCount;
  final String accountType;
  final String email;
  final String profilePicture;

  UserModel(
      this.userId,
      this.accessToken,
      this.expiresIn,
      this.createdAt,
      this.username,
      this.mediaCount,
      this.accountType,
      this.email,
      this.profilePicture);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        json["user_id"],
        json["access_token"],
        json["expires_in"],
        json["created_at"],
        json["username"],
        json["media_count"],
        json["account_type"],
        json["email"],
        json["profile_pic"]);
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "access_token": accessToken,
        "expires_in": expiresIn,
        "created_at": createdAt,
        "username": username,
        "media_count": mediaCount,
        "account_type": accountType,
        "email": email,
        "profile_pic": profilePicture
      };
}
