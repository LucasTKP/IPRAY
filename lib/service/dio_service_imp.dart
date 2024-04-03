import 'package:dio/dio.dart';
import 'package:ipray/service/dio_service.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://ipray-backend2.onrender.com/v1',
        headers: {
          'content-type': 'application/json; charset=utf-8',
        },
      ),
    );
  }
}
