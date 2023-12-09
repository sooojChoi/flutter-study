import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/nomad/WebtoonApp/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatefulWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  late SharedPreferences prefs;

  bool isRead = false;

  onButtonTap() async {
    prefs = await SharedPreferences.getInstance();

    // 최근 본 웹툰 데이터를 저장하기 위함
    var latedToons = prefs.getStringList('latedToons');
    if (latedToons != null) {
      if (latedToons.contains(widget.webtoonId) != true) {
        latedToons.add(widget.webtoonId);
      }
    } else {
      latedToons = [widget.webtoonId];
    }
    prefs.setStringList('latedToons', latedToons);
    // 몇 번째 화를 봤는지 알기 위함.
    prefs.setString(widget.webtoonId, widget.episode.title);
    prefs.setString("${widget.webtoonId}-episodeId", widget.episode.id);
    // 언제 몇시에 봤는지 알기 위함.
    // 1970년1월1일부터 현재까지의 시간을 밀리초로 나타낸 것. 이 값이 더 클수록 최근에 본 것.
    prefs.setInt(
        "${widget.webtoonId}-time", DateTime.now().millisecondsSinceEpoch);

    try {
      await launchUrlString(
          "https://comic.naver.com/webtoon/detail?titleId=${widget.webtoonId}&no=${widget.episode.id}");
      debugPrint(
          "https://comic.naver.com/webtoon/detail?titleId=${widget.webtoonId}&no=${widget.episode.id}");
    } catch (e) {
      debugPrint("error ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.episode.title;
    const titleLength = 18;
    if (widget.episode.title.length > titleLength) {
      title = "${widget.episode.title.substring(0, titleLength)}...";
    }

    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: const Offset(3, 4),
                color: Colors.black.withOpacity(0.25),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
