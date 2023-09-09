import 'dart:io';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class ProfileRepository {
  Future<DataState<ApiResponseEntity>> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? dob,
    String? city,
    String? gender,
    File? file,
  });
}
