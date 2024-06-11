import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_search_api.g.dart';

@RestApi(baseUrl: "https://openapi.naver.com/v1/search/")
abstract class PlaceSearchApi{
  factory PlaceSearchApi(Dio dio, {String baseUrl}) = _PlaceSearchApi;

  @GET("local.json")
  Future<Search> search(
        @Query("query") String query,
        @Query("display") int display,
      );
}


@JsonSerializable(explicitToJson: true)
class Search {
  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Place> items;

  Search({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items,
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}

@JsonSerializable()
class Place {
  String title;
  String link;
  String category;
  String description;
  String telephone;
  String address;
  String roadAddress;
  String mapx;
  String mapy;

  Place({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
