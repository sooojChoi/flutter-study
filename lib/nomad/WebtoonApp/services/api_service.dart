import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/nomad/WebtoonApp/models/webtoon_detail_model.dart';
import 'package:test1/nomad/WebtoonApp/models/webtoon_episode_model.dart';
import 'package:test1/nomad/WebtoonApp/models/webtoon_latest_model.dart';
import 'package:test1/nomad/WebtoonApp/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<List<WebtoonLatestModel>> getLatestToons() async {
    Map<WebtoonLatestModel, int> webtoonInstances = {};
    List<WebtoonLatestModel> result = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      // 최근 본 웹툰 데이터 가져오기
      var prefs = await SharedPreferences.getInstance();
      var latedToons = prefs.getStringList('latedToons');
      if (latedToons != null) {
        for (var webtoon in webtoons) {
          // 이 웹툰이 최근 본 웹툰 리스트에 들어있으면 배열에 추가.
          if (latedToons.contains(webtoon['id']) == true) {
            var episodeTitle = prefs.getString(webtoon['id']);
            var timestamp = prefs.getInt("${webtoon['id']}-time");
            var episodeId = prefs.getString("${webtoon['id']}-episodeId");
            webtoonInstances[WebtoonLatestModel.fromJson(
                webtoon, episodeTitle!, episodeId!)] = timestamp!;
          }
        }
        // value값(timestamp) 기준으로 정렬함.
        var sortedWebtoonInstances = Map.fromEntries(
            webtoonInstances.entries.toList()
              ..sort((e1, e2) => e2.value.compareTo(e1.value)));

        // 정렬된 Map을 이용해서 리스트에 순서대로 담아준다.
        sortedWebtoonInstances.forEach((key, value) {
          result.add(key);
        });
      }

      // 최근 본 웹툰이 하나도 없으면 빈 배열 리턴됨.
      return result;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }

      return episodesInstances;
    }
    throw Error();
  }
}
