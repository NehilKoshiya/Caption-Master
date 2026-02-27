class CategoryModel {
  final int id;
  final String name;
  final String image;
  final List<String> messages;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.messages,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      messages: List<String>.from(json['captions']),
    );
  }
}
