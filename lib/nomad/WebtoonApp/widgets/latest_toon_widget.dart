import 'package:flutter/material.dart';
import 'package:test1/nomad/WebtoonApp/screens/latest_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LatestToon extends StatefulWidget {
  final String toonTitle, episodeTitle, thumb, webtoonId, episodeId;
  final bool deleteType;

  const LatestToon({
    super.key,
    required this.toonTitle,
    required this.episodeTitle,
    required this.thumb,
    required this.webtoonId,
    required this.episodeId,
    required this.deleteType,
  });

  @override
  State<LatestToon> createState() => _LatestToonState();
}

class _LatestToonState extends State<LatestToon> {
  openToon() async {
    try {
      await launchUrlString(
          "https://comic.naver.com/webtoon/detail?titleId=${widget.webtoonId}&no=${widget.episodeId}");
      debugPrint(
          "https://comic.naver.com/webtoon/detail?titleId=${widget.webtoonId}&no=${widget.episodeId}");
    } catch (e) {
      debugPrint("error ${e.toString()}");
    }
  }

  deleteWidget() {}

  @override
  Widget build(BuildContext context) {
    var newWebtonTitle = widget.toonTitle;
    var newEpisodeTitle = widget.episodeTitle;
    if (widget.episodeTitle.length > 19) {
      newEpisodeTitle = "${widget.episodeTitle.substring(0, 19)}...";
    }
    if (widget.toonTitle.length > 15) {
      newWebtonTitle = "${widget.toonTitle.substring(0, 15)}...";
    }

    return GestureDetector(
      onTap: widget.deleteType
          ? () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          '기록을 지우시겠습니까?',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: deleteWidget,
                              child: const Text(
                                '예',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '아니오',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          : openToon,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            color: Colors.green[400],
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
            vertical: 11,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      widget.thumb,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newWebtonTitle,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        newEpisodeTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              widget.deleteType
                  ? const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                      size: 45,
                    )
                  : const Icon(
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
