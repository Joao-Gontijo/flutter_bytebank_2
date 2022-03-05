import 'dart:convert';

import 'package:bytebank_2/http/webclient.dart';
import 'package:bytebank_2/models/transaction.dart';
import 'package:http/http.dart';

import '../key_consts.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(Constants.uri).timeout(const Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    List<Transaction> transactions = _toTransactions(decodedJson);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(Constants.uri,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(List<dynamic> decodedJson) {
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> element in decodedJson) {
      transactions.add(Transaction.fromJson(element));
    }
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
