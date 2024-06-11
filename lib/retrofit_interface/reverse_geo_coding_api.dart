import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'reverse_geo_coding_api.g.dart';

@RestApi(
    baseUrl: "https://naveropenapi.apigw.ntruss.com")
abstract class ReverseGeoCodingApi {
  factory ReverseGeoCodingApi(Dio dio) = _ReverseGeoCodingApi;

  @GET("/map-reversegeocode/v2/gc")
  Future<GeoCodeResponse> reverseGeocode(
      @Query("coords") String coords,
      @Query("orders") String orders,
      @Query("output") String output);
}



@JsonSerializable()
class GeoCodeResponse {
  final Status status;
  final List<Result> results;

  GeoCodeResponse({
    required this.status,
    required this.results,
  });

  factory GeoCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$GeoCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeoCodeResponseToJson(this);
}

@JsonSerializable()
class Status {
  final int code;
  final String name;
  final String message;

  Status({
    required this.code,
    required this.name,
    required this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable()
class Result {
  final String name;
  final Code code;
  final Region region;
  final Land? land; // 추가된 부분

  Result({
    required this.name,
    required this.code,
    required this.region,
    required this.land, // 추가된 부분
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Code {
  final String id;
  final String type;
  final String mappingId;

  Code({
    required this.id,
    required this.type,
    required this.mappingId,
  });

  factory Code.fromJson(Map<String, dynamic> json) =>
      _$CodeFromJson(json);

  Map<String, dynamic> toJson() => _$CodeToJson(this);
}

@JsonSerializable()
class Region {
  final Area area0;
  final Area area1;
  final Area area2;
  final Area area3;
  final Area area4;

  Region({
    required this.area0,
    required this.area1,
    required this.area2,
    required this.area3,
    required this.area4,
  });

  factory Region.fromJson(Map<String, dynamic> json) =>
      _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable()
class Area {
  final String name;
  final Coords coords;

  Area({
    required this.name,
    required this.coords,
  });

  factory Area.fromJson(Map<String, dynamic> json) =>
      _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);
}

@JsonSerializable()
class Coords {
  final CenterCoords center;

  Coords({
    required this.center,
  });

  factory Coords.fromJson(Map<String, dynamic> json) =>
      _$CoordsFromJson(json);

  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}

@JsonSerializable()
class CenterCoords {
  final String crs;
  final double x;
  final double y;

  CenterCoords({
    required this.crs,
    required this.x,
    required this.y,
  });

  factory CenterCoords.fromJson(Map<String, dynamic> json) =>
      _$CenterCoordsFromJson(json);

  Map<String, dynamic> toJson() => _$CenterCoordsToJson(this);
}

@JsonSerializable()
class Land {
  final String type;
  final String name;
  final String number1;
  final String number2;
  final Coords coords;

  Land({
    required this.type,
    required this.name,
    required this.number1,
    required this.number2,
    required this.coords,
  });

  factory Land.fromJson(Map<String, dynamic> json) =>
      _$LandFromJson(json);

  Map<String, dynamic> toJson() => _$LandToJson(this);
}