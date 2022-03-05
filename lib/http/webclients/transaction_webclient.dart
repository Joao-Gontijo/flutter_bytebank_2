import 'dart:convert';

import 'package:bytebank_2/http/webclient.dart';
import 'package:bytebank_2/models/contact.dart';
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
    Map<String, dynamic> transactionMap = _toMap(transaction);

    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(Constants.uri,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    Map<String, dynamic> json = jsonDecode(response.body);
    return _toTransaction(json);
  }

  List<Transaction> _toTransactions(List<dynamic> decodedJson) {
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

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      }
    };
    return transactionMap;
  }

  Transaction _toTransaction(Map<String, dynamic> json) {
    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }
}
