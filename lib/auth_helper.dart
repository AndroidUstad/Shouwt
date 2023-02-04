import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'config/strings.dart';
import 'core/api_constants.dart';
import 'core/datasource/local_data_source.dart';

@injectable
class AuthHelper {
  final LocalDataSource localDataSource;
  final Dio dio;

  AuthHelper(this.localDataSource, this.dio);

  Future<bool> isAuthorized() async {
    String url = Strings.baseUrl + ApiConstants.profile;
    try {
      final user = localDataSource.getUserData();
      if (user == null) return false;
      final id = user.data!.user!.userId!;
      final response = await dio.get(
        url,
        queryParameters: {
          'session_id': user.auth!.authToken!,
          'user_id': id,
        },
      );
      return response.statusCode == 200;
    } on DioError catch (e) {
      if (e.response == null) return false;
      return e.response!.statusCode != 401;
    }
  }
}
