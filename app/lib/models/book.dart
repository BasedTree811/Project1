class Book {

  final String id;
  final String title;
  final String author;
  final String genre;
  final String description;
  final String filePath;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.filePath,
  });

  factory Book.fromJson(
      Map<String, dynamic> json,
      ) {

    return Book(

      id: json['id_book'],

      title: json['title'],

      author: json['author'],

      genre: json['genre'],

      description: json['description'],

      filePath: json['file_path'] ?? '',
    );
  }
}