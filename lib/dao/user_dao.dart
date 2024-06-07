import 'package:cloud_firestore/cloud_firestore.dart';


// 영화 데이터 전체를 가져오는 함수
Future<List<Map<String, dynamic>>> getMovieData() async {
  // movie_data 컬렉션에 저장되어 있는 모든 문서를 가져온다.
  var querySnapShot = await FirebaseFirestore.instance.collection('movie_data').get();

  // 데이터를 담을 리스트
  List<Map<String, dynamic>> results = [];

  // 데이터를 리스트에 담아준다.
  // 컬렉션에 담긴 모든 문서를 가져와 반복한다.
  for(var doc in querySnapShot.docs){
    // 문서에 담긴 데이터를 맵으로 추출하여 리스트에 담는다.
    results.add(doc.data());
  }

  return results;
}