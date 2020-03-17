import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '588B5812-0A93-4E91-837B-8481D91A976D';

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoExchangeRates = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';

      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastRate = decodedData['rate'];
        cryptoExchangeRates[crypto] = lastRate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'GET failed';
      }
    }
    return cryptoExchangeRates;
  }
}
