import 'dart:convert';

import 'package:bytebank_2/http/key_consts.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('REQUEST');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('RESPONSE');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(Constants.uri);
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> element in decodedJson) {
    final Map<String, dynamic> contactJson = element['contact'];
    final Transaction transaction = Transaction(
      element['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}
