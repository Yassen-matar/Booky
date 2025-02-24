class BookEntity {
  final String bookId;

  final String? image;

  final String title;

  final String? authorName;

  final num? price;

  final num? rating;
  final String? description;

  BookEntity(
      {required this.image,
      required this.title,
      required this.authorName,
      required this.price,
      required this.rating,
      required this.description,
      required this.bookId});
}
