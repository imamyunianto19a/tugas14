// Model Class: memetakan JSON dari TheCatAPI ke objek Dart.
// Contoh JSON dari https://api.thecatapi.com/v1/images/search:
// {
//   "id": "MTY3ODIyMQ",
//   "url": "https://cdn2.thecatapi.com/images/MTY3ODIyMQ.jpg",
//   "width": 500,
//   "height": 333
// }
class CatModel {
  final String id;
  final String url;
  final int width;
  final int height;

  CatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  // Factory constructor .fromJson (wajib sesuai spesifikasi tugas)
  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }
}
