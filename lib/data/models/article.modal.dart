class ArticleModal {
  String? key;
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;
  final String ownerUid;

  ArticleModal({
    this.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    required this.ownerUid
  });
}
