import 'dart:convert';
import 'package:byte_bank_database/http/webclient.dart';
import 'package:byte_bank_database/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((json) => Transaction.fromJson(json)).toList();

  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
