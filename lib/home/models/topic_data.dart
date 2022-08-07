import 'dart:convert';

TopicData userDataFromJson(String str) => TopicData.fromJson(json.decode(str));

String userDataToJson(TopicData data) => json.encode(data.toJson());

class TopicData {
  TopicData({

    this.imageUrl,
    this.title,
    this.topicUrl,
    this.thumbnail,
  });

  final String topicUrl;
  final String title;
  final String imageUrl;
  final String thumbnail;

  factory TopicData.fromJson(Map<String, dynamic> json) => TopicData(

        topicUrl: json['topicUrl'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        thumbnail: json['thumbnail']
      );

  Map<String, dynamic> toJson() => {
    
        'topicUrl': topicUrl,
        'title': title,
        'imageUrl': imageUrl,
        'thumbnail':thumbnail,
      };
}

class TopicsData {
  TopicsData({this.topics});
  List<TopicData> topics;
  factory TopicsData.fromJson(Map<String, dynamic> json) => TopicsData(
        topics: List<TopicData>.from(
            json["articles"].map((x) => TopicData.fromJson(x))),
      );
}
