class Blog {
  int? id;
  Attributes? attributes;

  Blog({
    required this.id,
    required this.attributes,
  });

  factory Blog.fromJson(json) => Blog(
        id: json['id'],
        attributes: Attributes.fromJson(json['attributes']),
      );
}

class Attributes {
  String? title;
  String? body;
  DateTime? createdAt;

  Attributes({
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Attributes.fromJson(json) => Attributes(
        title: json['title'],
        body: json['body'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'createdAt': createdAt,
      };
}
