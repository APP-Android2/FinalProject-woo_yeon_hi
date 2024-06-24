import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/ledger_model.dart';
import 'package:woo_yeon_hi/provider/ledger_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_modal_bottom_sheet.dart';

class LedgerListView extends StatefulWidget {
  //const LedgerListView({super.key});
  List<Ledger> selectedLedgerDate;
  LedgerProvider provider;

  LedgerListView(this.selectedLedgerDate, this.provider, {super.key});

  @override
  State<LedgerListView> createState() => _LedgerListViewState();
}

class _LedgerListViewState extends State<LedgerListView> {
  // 캘린더 이벤트 텍스트에 콤마
  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  // 날짜 포맷팅
  String formatLedgerDate(String ledgerDate) {
    try {
      DateTime dateTime = DateTime.parse(ledgerDate);
      String formattedDate = DateFormat('yyyy. M. d.(E) kk:mm', 'ko').format(dateTime);
      return formattedDate;
    } catch (e) {
      // 유효하지 않은 날짜 형식일 경우
      return 'Invalid Date';
    }
  }

  // 이벤트 리스트의 카테고리 아이콘 정의
  String getIconPath(LedgerCategory category) {
    const categoryIconMap = {
      LedgerCategory.FOOD_EXPENSES: 'lib/assets/icons/spoon_fork.svg',
      LedgerCategory.CAFFE: 'lib/assets/icons/coffee_cup.svg',
      LedgerCategory.PUBLIC_TRANSPORT: 'lib/assets/icons/bus.svg',
      LedgerCategory.SHOPPING: 'lib/assets/icons/shopping_cart.svg',
      LedgerCategory.CULTURE: 'lib/assets/icons/culture_popcorn.svg',
      LedgerCategory.HOBBY: 'lib/assets/icons/hobby_puzzle.svg',
      LedgerCategory.DATE_WITH: 'lib/assets/icons/lover.svg',
      LedgerCategory.GAME: 'lib/assets/icons/game.svg',
      LedgerCategory.TRAVEL: 'lib/assets/icons/travel.svg',
      LedgerCategory.DWELLING: 'lib/assets/icons/maintain_home.svg',
      LedgerCategory.LIFE: 'lib/assets/icons/life_leaf.svg',
      LedgerCategory.ETC: 'lib/assets/icons/etc_more.svg',
      LedgerCategory.DEPOSIT: 'lib/assets/icons/money_deposit.svg',
      LedgerCategory.INCOME_ADD: 'lib/assets/icons/income_add.svg',
      LedgerCategory.INCOME_BONUS: 'lib/assets/icons/income_bonus.svg',
      LedgerCategory.INCOME_ETC: 'lib/assets/icons/etc_more.svg',
    };

    return categoryIconMap[category] ?? 'lib/assets/icons/etc_more.svg';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemCount: widget.selectedLedgerDate.length,
          itemBuilder: (context, index) {
            final ledger = widget.selectedLedgerDate[index];
            return makeListItem(ledger);
          },
        ),
    );
  }

  // 리스트뷰 항목 하나를 구성
  Widget makeListItem(Ledger ledger){
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(getIconPath(ledger.ledgerCategory), width: 24, height: 24),
                  const SizedBox(width: 10),
                  Text(ledger.ledgerTitle, style: const TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        // 핸들 바
                        showDragHandle: true,
                        backgroundColor: ColorFamily.white,
                        builder: (BuildContext context) {
                          return LedgerModalBottomSheet(ledger);
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset('lib/assets/icons/horizontal_more.svg'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('일시', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
              Text(formatLedgerDate(ledger.ledgerDate), style: const TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('금액', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
              Text('${ledger.ledgerType.type == 0 ? '-' : '+'}${formatNumber(ledger.ledgerAmount)}원', style: const TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('메모', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
              Text(ledger.ledgerMemo, style: const TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          const SizedBox(height: 15),
          // 구분 선
          const Divider(color: ColorFamily.gray, thickness: 0.5),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
