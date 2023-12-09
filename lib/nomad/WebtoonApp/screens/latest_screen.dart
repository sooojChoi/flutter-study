import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/nomad/WebtoonApp/services/api_service.dart';
import 'package:test1/nomad/WebtoonApp/widgets/latest_toon_widget.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({super.key});

  @override
  State<LatestScreen> createState() => LatestScreenState();
}

class LatestScreenState extends State<LatestScreen> {
  Future<dynamic> webtoons = ApiService.getLatestToons();
  bool isDeleteType = false;

  deleteItem(webtoonId) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();

    // 최근 본 웹툰 데이터를 저장하기 위함
    var latedToons = prefs.getStringList('latedToons');
    if (latedToons != null) {
      latedToons.remove(webtoonId);
      prefs.setStringList('latedToons', latedToons);
    }

    prefs.remove(webtoonId);
    prefs.remove("$webtoonId-episodeId");
    prefs.remove("$webtoonId-time");

    isDeleteType = false;
    webtoons = ApiService.getLatestToons();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 음영 조절
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          "최근 본 웹툰",
          style: GoogleFonts.gowunBatang(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isDeleteType = !isDeleteType;
              setState(() {});
            },
            icon: Icon(
              isDeleteType
                  ? Icons.cancel_outlined
                  : Icons.delete_outline_rounded,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: webtoons,
          // webtoons에 데이터가 응답하면, snapshot으로 확인 가능.
          // snapshot.data가 응답된 결과.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return const Center(
                    child: Text(
                  '최근 본 웹툰이 없습니다.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
                ));
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  RefreshIndicator makeList(AsyncSnapshot<dynamic> snapshot) {
    //많은 양의 데이터를 보여주고자 할 때는 ListView가 적합.
    // 문제는, 최적화되지 않았다는 것이다. 한 번에 모든 데이터를 로딩한다.
    // 메모리 최적화를 위해 사용자가 보고 있는 데이터만 로딩해야 한다.
    // 그렇게 최적화된 것이 ListView.builder이다.
    // ListView.separated를 사용하면 separatorBuilder라는 속성을 추가로 가짐.
    // 리스트 아이템 사이에 widget 구현 가능.

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          webtoons = ApiService.getLatestToons();
        });
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data.length!, // 몇 개의 데이터를 로딩할건지
        itemBuilder: (context, index) {
          // 사용자가 보고 있는 데이터만 build
          var webtoon = snapshot.data![index];
          return LatestToon(
            toonTitle: webtoon.toonTitle,
            episodeTitle: webtoon.episodeTitle,
            thumb: webtoon.thumb,
            webtoonId: webtoon.webtoonId,
            episodeId: webtoon.episodeId,
            deleteType: isDeleteType,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }
}
