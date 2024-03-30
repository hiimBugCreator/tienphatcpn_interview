class Post {
  final String author;
  final int createdDate;
  final String image;
  final String title;
  final int liked;
  final int shared;
  final int comments;

  Post({
    required this.author,
    required this.createdDate,
    required this.image,
    required this.title,
    required this.liked,
    required this.shared,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json['author'],
      createdDate: json['createdDate'],
      image: "${json['image']}.jpg",
      title: json['title'],
      liked: json['liked'],
      shared: json['shared'],
      comments: json['comments'],
    );
  }
}
