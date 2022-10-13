import 'package:bitcoin_ticker_flutter/services/networking.dart';

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

//const apiKey = '077BE1B6-357E-414A-9814-4B047D6D4F86';// joao
const apiKey = 'F06A7D05-95BA-49B0-AA5F-99FC23C795CC';// bind

const coinapiMapURL = 'https://rest.coinapi.io/v1/exchangerate';



// Ou uso a classe "CoinModel" ou a classe "CoinData"
class CoinData {
  // Métodos

}

// Esta classe "CoinModel" devia estar num ficheiro diferente
class CoinModel {
  // Métodos
  //Future<dynamic> getCoin(String cityName) async {
  // Future<dynamic> getCoin() async {
  //   var asset_id_base = 'BTC';
  //   var asset_id_quote = 'USD';
  //
  //   NetworkHelper networkHelper = NetworkHelper('$coinapiMapURL/$asset_id_base/$asset_id_quote?apikey=$apiKey');
  //
  //   var coinData = await networkHelper.getData();
  //   print(coinData);
  //   return coinData;
  // }

  Future<dynamic> getCoinData() async {
    // moeda inicial
    var asset_id_base = 'BTC';
    // moeda final
    var asset_id_quote = 'USD';

    NetworkHelper networkHelper = NetworkHelper('$coinapiMapURL/$asset_id_base/$asset_id_quote?apikey=$apiKey');

    var coinData = await networkHelper.getData();
    print(coinData);
    return coinData;
  }
}
