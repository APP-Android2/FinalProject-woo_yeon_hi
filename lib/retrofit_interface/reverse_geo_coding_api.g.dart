// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse_geo_coding_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoCodeResponse _$GeoCodeResponseFromJson(Map<String, dynamic> json) =>
    GeoCodeResponse(
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeoCodeResponseToJson(GeoCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      code: (json['code'] as num).toInt(),
      name: json['name'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      name: json['name'] as String,
      code: Code.fromJson(json['code'] as Map<String, dynamic>),
      region: Region.fromJson(json['region'] as Map<String, dynamic>),
      land: json['land'] == null
          ? null
          : Land.fromJson(json['land'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'region': instance.region,
      'land': instance.land,
    };

Code _$CodeFromJson(Map<String, dynamic> json) => Code(
      id: json['id'] as String,
      type: json['type'] as String,
      mappingId: json['mappingId'] as String,
    );

Map<String, dynamic> _$CodeToJson(Code instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'mappingId': instance.mappingId,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      area0: Area.fromJson(json['area0'] as Map<String, dynamic>),
      area1: Area.fromJson(json['area1'] as Map<String, dynamic>),
      area2: Area.fromJson(json['area2'] as Map<String, dynamic>),
      area3: Area.fromJson(json['area3'] as Map<String, dynamic>),
      area4: Area.fromJson(json['area4'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'area0': instance.area0,
      'area1': instance.area1,
      'area2': instance.area2,
      'area3': instance.area3,
      'area4': instance.area4,
    };

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      name: json['name'] as String,
      coords: Coords.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'name': instance.name,
      'coords': instance.coords,
    };

Coords _$CoordsFromJson(Map<String, dynamic> json) => Coords(
      center: CenterCoords.fromJson(json['center'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'center': instance.center,
    };

CenterCoords _$CenterCoordsFromJson(Map<String, dynamic> json) => CenterCoords(
      crs: json['crs'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$CenterCoordsToJson(CenterCoords instance) =>
    <String, dynamic>{
      'crs': instance.crs,
      'x': instance.x,
      'y': instance.y,
    };

Land _$LandFromJson(Map<String, dynamic> json) => Land(
      type: json['type'] as String,
      name: json['name'] as String,
      number1: json['number1'] as String,
      number2: json['number2'] as String,
      coords: Coords.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LandToJson(Land instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'number1': instance.number1,
      'number2': instance.number2,
      'coords': instance.coords,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ReverseGeoCodingApi implements ReverseGeoCodingApi {
  _ReverseGeoCodingApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://naveropenapi.apigw.ntruss.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GeoCodeResponse> reverseGeocode(
    String coords,
    String orders,
    String output,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'coords': coords,
      r'orders': orders,
      r'output': output,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GeoCodeResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/map-reversegeocode/v2/gc',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GeoCodeResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
