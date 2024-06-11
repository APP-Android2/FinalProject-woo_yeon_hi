import 'package:woo_yeon_hi/model/enums.dart';

class Ledger{
  int ledgerIdx; // 가계부 번호
  int ledgerUserIdx; // 가계부 작성자
  String ledgerDate; // 발생 날짜
  int ledgerAmount; // 금액
  LedgerType ledgerType; // 가계부 타입
  String ledgerTitle; // 제목(타이틀)
  LedgerCategory ledgerCategory; // 카테고리 번호
  String ledgerMemo; // 메모
  LedgerState ledgerState; // 가계부 상태
  String ledgerModifyDate; // 가계부 수정 날짜

  // 기본 생성자
  Ledger(
      {required this.ledgerIdx,
       required this.ledgerUserIdx,
       required this.ledgerDate,
       required this.ledgerAmount,
       required this.ledgerType,
       required this.ledgerTitle,
       required this.ledgerCategory,
       required this.ledgerMemo,
       required this.ledgerState,
       required this.ledgerModifyDate,
      });

  // 팩토리 생성자: Map<String, dynamic> 데이터를 받아 Ledger 객체를 생성
  factory Ledger.fromMap(Map<String, dynamic> map) {
    return Ledger(
      ledgerIdx: map['ledger_idx'],
      ledgerUserIdx: map['ledger_user_idx'],
      ledgerDate: map['ledger_date'],
      //ledgerDate: DateTime.parse(map['ledger_date']),
      ledgerAmount: map['ledger_amount'],
      ledgerType: LedgerType.fromValue(map['ledger_type']),  // 정수 값을 다시 열거형으로 변환합니다.
      ledgerTitle: map['ledger_title'],
      ledgerCategory: LedgerCategory.fromValue(map['ledger_category']),
      ledgerMemo: map['ledger_memo'],
      ledgerState: LedgerState.fromValue(map['ledger_state']),
      ledgerModifyDate: map['ledger_modify_date'],
    );
  }

  // toMap 메서드: Ledger 객체를 Map<String, dynamic> 형태로 변환
  Map<String, dynamic> toMap(){
    return{
      'ledger_idx': ledgerIdx,
      'ledger_user_idx': ledgerUserIdx,
      'ledger_date': ledgerDate,
      'ledger_amount': ledgerAmount,
      'ledger_type': ledgerType.type, // 열거형을 정수 값으로 변환.
      'ledger_title': ledgerTitle,
      'ledger_category': ledgerCategory.number,
      'ledger_memo': ledgerMemo,
      'ledger_state': ledgerState.state,
      'ledger_modify_date': ledgerModifyDate,
    };
  }
}