import 'package:intl/intl.dart';

/// Datetime 객체를 날짜 저장 형식으로 변환합니다.
String dateToString(DateTime date) {
  String year = DateFormat('yyyy').format(date);
  String month = date.month.toString().padLeft(2, " ");
  String day = date.day.toString().padLeft(2, " ");
  return '$year.$month.$day.';
}

/// 'yyyy.MM.dd.' 형태의 문자열 날짜 데이터를 DateTime으로 변환합니다.
DateTime stringToDate(String date){
  List<String> splitDate = date.split(".");
  String year = splitDate[0];
  String month = splitDate[1].replaceAll(" ", "");
  String day = splitDate[2].replaceAll(" ", "");

  return DateTime(int.parse(year), int.parse(month), int.parse(day));
}

String listToString(List<int> list) {
  return list.join(',');
}

List<int> stringToList(String input) {
  List<int> result = [];

  List<String> parts = input.split(',');
  for (String part in parts) {
    result.add(int.parse(part.trim()));
  }

  return result;
}


/// FlutterSecureStorage에 저장된 value객체(String)를 int타입으로 변환합니다.
int stringToInt(String value){
  int number = 0;
  try {
    number = int.parse(value);
  } catch (e) {
    print('Error: $e');
  }
  return number;
}

