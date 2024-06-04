import 'package:flutter/material.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class DiaryDetailContent extends StatefulWidget {
  const DiaryDetailContent({super.key});

  @override
  State<DiaryDetailContent> createState() => _DiaryDetailContentState();
}

class _DiaryDetailContentState extends State<DiaryDetailContent> {
  final TextEditingController _titleTextEditController = TextEditingController(
    text: "비오는 한강 데이트"
  );
  final TextEditingController _contentTextEditController = TextEditingController(
    text: "오늘은 여자친구와 함께 비가 내리는 한강으로 데이트를 다녀왔다. 비가 와서 그런지 한강의 분위기가 한층 더 로맨틱하게 느껴졌다. 우리는 알록달록한 우산을 나란히 쓰고 강변을 따라 천천히 걸었다. 빗소리와 강물이 어우러져 마음이 편안해졌고, 여자친구의 미소가 비에 반사되어 더욱 빛났다. 그 순간이 너무나 아름다워서 눈을 뗄 수가 없었다.\n\n중간중간 비가 조금씩 그쳐서 우리는 한강공원을 따라 이어진 산책로를 천천히 거닐었다. 비가 내린 후의 상쾌한 공기가 우리의 마음을 더욱 밝게 만들어 주었다. 길을 걷다 보니 작은 꽃들이 비에 젖어 더욱 선명한 색을 띠고 있었고, 그 모습에 우리는 자연의 아름다움을 새삼 느낄 수 있었다. 손을 꼭 잡고 걷는 동안 우리는 서로의 일상 이야기를 나누며 즐거운 시간을 보냈다.\n\n비가 다시 조금씩 내리기 시작하자 우리는 가까운 카페에 들어가 따뜻한 커피를 마시기로 했다. 창밖으로 보이는 한강의 풍경은 평소와는 다른 아름다움이 있었다. 빗방울이 창문을 타고 흘러내리는 모습을 보며, 우리는 서로의 손을 꼭 잡고 따뜻한 커피 한 잔을 나눴다. 카페 안에서 흐르는 잔잔한 음악이 우리의 대화를 한층 더 감미롭게 만들어 주었다.\n\n커피를 마신 후 우리는 다시 밖으로 나왔다. 이번에는 한강을 조금 더 특별하게 즐기기 위해 작은 배를 타보기로 했다. 비록 비가 조금 내렸지만, 우비를 입고 타는 배는 색다른 재미를 주었다. 물안개가 자욱한 한강 위에서 우리는 손을 꼭 잡고 서로의 따뜻함을 느꼈다. 배 위에서 바라본 한강의 풍경은 평소와는 또 다른 매력을 가지고 있었다. 물안개 속에서 마치 다른 세상에 와 있는 듯한 느낌이 들었다.\n\n한강 위에서의 시간이 너무나 빨리 지나갔다. 배에서 내려 다시 강변을 걷다 보니 저녁이 되어가고 있었다. 비에 젖은 한강의 야경은 더욱 신비롭게 빛났다. 우리는 잠시 벤치에 앉아 비에 젖은 한강의 모습을 감상하며 오늘 하루를 되돌아보았다. 여자친구와 함께한 모든 순간이 너무나 소중하게 느껴졌다.\n\n오늘의 데이트는 우리에게 잊지 못할 추억이 되었다. 비오는 날씨 덕분에 한강은 평소보다 더욱 평화롭고 조용했고, 우리는 그 속에서 서로의 마음을 더욱 깊이 나눌 수 있었다. 여자친구와 함께라면 어떤 날씨도 행복한 날이 될 수 있다는 걸 다시 한 번 깨달았다. 오늘 하루가 너무나 특별하고 소중하게 느껴진다. 앞으로도 이런 특별한 날을 함께 만들어 가고 싶다. 비오는 한강 데이트는 우리에게 앞으로도 오래도록 기억될 것이다.\n"
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Card(
        color: ColorFamily.white,
        surfaceTintColor: ColorFamily.white,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 제목
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  controller: _titleTextEditController,
                  cursorColor: ColorFamily.black,
                  enabled: false,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      counter: SizedBox()
                  ),
                  style: const TextStyle(
                      fontFamily: FontFamily.mapleStoryLight,
                      fontSize: 20,
                      color: ColorFamily.black
                  ),
                )),
            // 내용
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  maxLines: null,
                  controller: _contentTextEditController,
                  keyboardType: TextInputType.multiline,
                  cursorColor: ColorFamily.black,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyleFamily.normalTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
