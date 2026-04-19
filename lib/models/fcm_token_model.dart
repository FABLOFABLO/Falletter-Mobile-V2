class FcmTokenModel {
  final int id;

  FcmTokenModel({required this.id});

  factory FcmTokenModel.fromJson(Map<String, dynamic> json) {
    return FcmTokenModel(id: json['id']);
  }
}