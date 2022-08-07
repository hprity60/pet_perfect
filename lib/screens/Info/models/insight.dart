class Insight {
  String title;
  String imageUrl;
  String thumbnail;
  String description;
  List<Map<String, String>> info;
  List<Map<String, String>> moreInsights;

  Insight({
    this.description,
    this.imageUrl,
    this.thumbnail,
    this.title,
    this.info,
    this.moreInsights,
  });

  factory Insight.fromJson(Map<String, dynamic> json) => Insight(
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        info: json['info'],
        thumbnail: json['thumbnail'],
        moreInsights: json['moreInsights']
      );
}
