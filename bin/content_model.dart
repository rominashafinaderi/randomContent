class Content {
  int? id;
  String? title;
  String? coverImage;
  bool? chosen;
  ContentType? contentType;
  bool? isSlider;

  Content({
    this.id,
    this.title,
    this.coverImage,
    this.chosen,
    this.contentType,
    this.isSlider,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      title: json['title'],
      coverImage: json['coverImage'],
      chosen: json['chosen'],
      contentType: json['contentType_id'] != null ? ContentType.fromJson(json['contentType_id']) : null,
      isSlider: json['isSlider'],
    );
  }
}

class ContentType {
  int? id;
  String? name;

  ContentType({
    this.id,
    this.name,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) {
    return ContentType(
      id: json['id'],
      name: json['name'],
    );
  }
}
