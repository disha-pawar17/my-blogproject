
//MODEL CLASS FOR FAVORITE DATA

class FavoriteModel {
  FavoriteModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  int postId;
  int id;
  String name;
  String email;
  String body;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      postId: json["postId"],
      id: json["id"],
      name: json["name"],
      email: json["email"],
      body: json["body"],
    );
  }
}