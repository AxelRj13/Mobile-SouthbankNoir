import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

  Future<HttpResponse<ApiResponseModel>> updateProfile(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? dob,
    String? city,
    File? file,
  ) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{};
    final data = FormData();
    if (firstName != null) {
      data.fields.add(
        MapEntry(
          'first_name',
          firstName,
        ),
      );
    }
    if (lastName != null) {
      data.fields.add(
        MapEntry(
          'last_name',
          lastName,
        ),
      );
    }
    if (phone != null) {
      data.fields.add(
        MapEntry(
          'phone',
          phone,
        ),
      );
    }
    if (dob != null) {
      data.fields.add(
        MapEntry(
          'date_of_birth',
          dob,
        ),
      );
    }
    if (city != null) {
      data.fields.add(
        MapEntry(
          'city',
          city,
        ),
      );
    }
    if (email != null) {
      data.fields.add(
        MapEntry(
          'email',
          email,
        ),
      );
    }
    if (file != null) {
      final filename = file.path.split(Platform.pathSeparator).last;
      data.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(
            file.path,
            filename: filename,
            contentType: MediaType.parse("${lookupMimeType(filename)}"),
          ),
        ),
      );
    }
    final result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<HttpResponse<ApiResponseModel>>(
        Options(
          method: 'POST',
          headers: headers,
          extra: extra,
          contentType: 'multipart/form-data',
        )
            .compose(
              _dio.options,
              'profile/update',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(
              baseUrl: _combineBaseUrls(
                _dio.options.baseUrl,
                apiBaseUrl,
              ),
            ),
      ),
    );
    final value = ApiResponseModel.fromJson(result.data!);
    final httpResponse = HttpResponse(value, result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
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
