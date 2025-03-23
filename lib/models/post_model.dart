class PostModel {
  final int id;
  final String description;
  final double price;
  final List<Map<String, dynamic>> media;
  final String status;
  final String product;
  final String category;
  int likes;
  final int userId; // User's identifier

  PostModel({
    required this.id,
    required this.description,
    required this.price,
    required this.media,
    required this.status,
    required this.product,
    required this.category,
    this.likes = 0,
    required this.userId,
  });

  // Empty post -> Placeholder (Caching)
  static PostModel cachePost(int id) {
    return PostModel(
      id: id,
      description: '',
      price: 0,
      media: [],
      status: '',
      product: '',
      category: '',
      likes: 0,
      userId: 0,
    );
  }
}
