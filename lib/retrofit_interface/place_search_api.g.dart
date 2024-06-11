// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      lastBuildDate: json['lastBuildDate'] as String,
      total: (json['total'] as num).toInt(),
      start: (json['start'] as num).toInt(),
      display: (json['display'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'total': instance.total,
      'start': instance.start,
      'display': instance.display,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      title: (json['title'] as String)
          .replaceAll("<b>", "")
          .replaceAll("</b>", " "),
      link: json['link'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      telephone: json['telephone'] as String,
      address: json['address'] as String,
      roadAddress: json['roadAddress'] as String,
      mapx: json['mapx'] as String,
      mapy: json['mapy'] as String,
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'category': instance.category,
      'description': instance.description,
      'telephone': instance.telephone,
      'address': instance.address,
      'roadAddress': instance.roadAddress,
      'mapx': instance.mapx,
      'mapy': instance.mapy,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PlaceSearchApi implements PlaceSearchApi {
  _PlaceSearchApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://openapi.naver.com/v1/search/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Search> search(
    String query,
    int display,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'display': display,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Search>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'local.json',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Search.fromJson(_result.data!);
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
