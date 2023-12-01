import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/nomad/WebtoonApp/models/webtoon_model.dart';
import 'package:test1/nomad/WebtoonApp/services/api_service.dart';
import 'package:test1/nomad/WebtoonApp/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<dynamic> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 음영 조절
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          "오늘의 웹툰",
          style: GoogleFonts.gowunBatang(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: webtoons,
          // webtoons에 데이터가 응답하면, snapshot으로 확인 가능.
          // snapshot.data가 응답된 결과.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
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

  ListView makeList(AsyncSnapshot<dynamic> snapshot) {
    //많은 양의 데이터를 보여주고자 할 때는 ListView가 적합.
    // 문제는, 최적화되지 않았다는 것이다. 한 번에 모든 데이터를 로딩한다.
    // 메모리 최적화를 위해 사용자가 보고 있는 데이터만 로딩해야 한다.
    // 그렇게 최적화된 것이 ListView.builder이다.
    // ListView.separated를 사용하면 separatorBuilder라는 속성을 추가로 가짐.
    // 리스트 아이템 사이에 widget 구현 가능.
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.length!, // 몇 개의 데이터를 로딩할건지
      itemBuilder: (context, index) {
        // 사용자가 보고 있는 데이터만 build
        var webtoon = snapshot.data![index];
        return Webtoon(
          id: webtoon.id,
          title: webtoon.title,
          thumb: webtoon.thumb,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
