import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:pokebankv2/models/class/transferidos.dart';
import 'package:pokebankv2/services/http/interceptadores/loggin_interceptadores.dart';
import 'package:http/http.dart' as http;

class TransfersWeb {
  Future<List<Transfers>> findAll() async {
    final InterceptedHttp client = InterceptedHttp.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(seconds: 5));
    final uriGet = Uri.parse("http://172.19.1.24:8080/transactions");
    final Response response = await http.get(uriGet);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transfers> listTransferidos = [];

    for (Map<String, dynamic> itemJson in decodedJson) {
      Transfers transferido = Transfers.fromJson(itemJson);
      listTransferidos.add(transferido);
    }

    return listTransferidos;
  }
  Future<dynamic> save(Transfers transfers, final String password, final String idIdempotence) async {
    final Map<String, dynamic> transferidosMap = {
      "id" : idIdempotence,
      "value": 1000,
      "contact": {
        "name": transfers.nomeTransferidos,
        "accountNumber": transfers.idTransferidos
      }
    };
    final String transferidosJson = jsonEncode(transferidosMap);
    final uriPost = Uri.parse("http://172.19.1.24:8080/transactions");
    final InterceptedHttp client = InterceptedHttp.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(seconds: 5));

    await Future.delayed(Duration(seconds: 5));
    final Response response = await client.post(uriPost,
        headers: {"Content-type": "application/json", "password": password},
        body: transferidosJson);

    if (response.statusCode == 400) {
      throw HttpException("Campo invalido", 400);
    }
    if (response.statusCode == 401) {
      throw HttpException("Senha incorreta", 401);
    }
    if (response.statusCode == 409) {
      throw HttpException("Transferência já executada", 409);
    }


    final Map<String, dynamic> responseJson = jsonDecode(response.body);

    return responseJson;
  }


}
class HttpException implements Exception {
  final String message;
  final int? statusCode;

  HttpException(this.message, this.statusCode);
}
