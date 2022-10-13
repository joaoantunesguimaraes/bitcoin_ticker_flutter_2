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

//const apiKey = '077BE1B6-357E-414A-9814-4B047D6D4F86';// joao
const apiKey = 'F06A7D05-95BA-49B0-AA5F-99FC23C795CC'; // bind
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  // Métodos

  // Create the Asynchronous method getCoinData() that returns a Future.
  Future getCoinData(String selectedCurrency) async {
    // Map que vai conter a lista de Moedas virtuais - Chave/valor - 'bitcoin', 'BTC'
    Map<String, String> cryptoPrices = {};

    // Popular o Map
    for (String crypto in cryptoList) {
      //String requestURL = '$coinAPIURL/$asset_id_base/$asset_id_quote?apikey=$apiKey';
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      // Make a GET request to the URL and wait for the response.
      http.Response response = await http.get(Uri.parse(requestURL));

      // Check that the request was successful.
      if (response.statusCode == 200) {
        // Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
        var decodedData = jsonDecode(response.body);
        // Get the last price of bitcoin with the key 'last'.
        double price = decodedData['rate'];
        // Output the lastPrice from the method.
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        //Handle any errors that occur during the request.
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
