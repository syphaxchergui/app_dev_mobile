class Activity {
  final String imageLink;
  final String title;
  final String category;
  final String location;
  final int minPersons;
  final double price;

  Activity({
    required this.imageLink,
    required this.title,
    required this.category,
    required this.location,
    this.minPersons = 1,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location': location,
      'category': category,
      'minPersons': minPersons,
      'price': price,
      'imageLink': imageLink,
    };
  }

  static Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'],
      location: json['location'],
      minPersons: json['minPersons'],
      category: json['category'],
      price: json['price'],
      imageLink: json['imageLink'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Activity && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
