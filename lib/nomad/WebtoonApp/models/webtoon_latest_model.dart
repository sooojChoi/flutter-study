class WebtoonLatestModel {
  final String toonTitle, thumb, episodeTitle, webtoonId, episodeId;

  // Constructor
  WebtoonLatestModel.fromJson(
      Map<String, dynamic> json, this.episodeTitle, this.episodeId)
      : toonTitle = json['title'],
        thumb = json['thumb'],
        webtoonId = json['id'];
}
