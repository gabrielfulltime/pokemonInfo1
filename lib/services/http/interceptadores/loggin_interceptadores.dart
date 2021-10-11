import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("==============================");
    print(">>>>REQUEST<<<<");
    print(">>>>Url = ${data.baseUrl}<<<<");
    print(">>>>Body = ${data.body}<<<<");
    print(">>>>heders = ${data.headers}<<<<");
    print(data.toString());

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("==============================");
    print(">>>>Response<<<<");
    print(data.toString());
    print(">>>>Body = ${data.body}<<<<");
    print(">>>>Heders = ${data.headers}<<<<");
    print(">>>>status Code = ${data.statusCode}<<<<");

    return data;
  }
}