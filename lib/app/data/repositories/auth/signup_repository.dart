import 'package:dio/dio.dart';

import '../../models/auth/sign_up_model.dart';
import '../../providers/api_provider.dart';

class SignupRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<Response> signupUser(SignUpModel userData) async {
    try {
      final response = await apiProvider.dio.post(
         '/auth/signup',
        data: userData.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw e.response?.data ?? {"message": "Signup failed"};
    }
  }
}
