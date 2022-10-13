import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'package:flutter/foundation.dart';


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Atributos / Propriedades
  String selectedCurrency = currenciesList.first;


  // Para o Android
  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItens = currenciesList
        .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ))
        .toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItens,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          //2: Call getData() when the picker/dropdown changes.
          getData();
        });
        icon: const Icon(Icons.arrow_downward);
      },
    );
  }

  // Para o Ios
  CupertinoPicker iosPicker() {
    List<Text> pickerItens = currenciesList.map<Text>((currency) => Text(currency)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        //2: Call getData() when the picker/dropdown changes.
        getData();
      },
      children: pickerItens,
    );
  }

  //12. Create a variable to hold the value and use in our Text Widget.
  // Give the variable a starting value of '?' before the data comes back from the async methods.
  // Map que vai conter a lista de Moedas virtuais - Chave/valor - 'bitcoin', 'BTC'
  Map<String, String> coinValues = {};
  bool isWaiting = false;

  //11. Create an async method here await the coin data from coin_data.dart
  void getData() async {
    isWaiting = true;
    try {
      // Não posso fazer cryptoList[0]
      // tem de ser para cada uma das criptomoedas
      //var data = await CoinData().getCoinData(selectedCurrency);
      Map<String, String> data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      //13. We can't await in a setState(). So you have to separate it out into 2 steps.
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up.
    // We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }


  Column makeCards() {
    //List<CryptoCard> cryptoCards = [];

    // for (String crypto in cryptoList) {
    //   cryptoCards.add(
    //     CryptoCard(
    //       cryptoCurrency: crypto,
    //       selectedCurrency: selectedCurrency,
    //       value: isWaiting ? '?' : coinValues[crypto]!,
    //     ),
    //   );
    // }

    // OU
    // cryptoList.forEach((crypto) {
    //     cryptoCards.add(
    //       CryptoCard(
    //         cryptoCurrency: crypto.toString(),
    //         selectedCurrency: selectedCurrency,
    //         value: isWaiting ? '?' : coinValues[crypto]!
    //       ),
    //     );
    // });
    // OU

    List<CryptoCard> cryptoCards = cryptoList.map((crypto) =>
      CryptoCard(
          cryptoCurrency: crypto.toString(),
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto]!
      ),
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: defaultTargetPlatform == TargetPlatform.android
                  ? androidDropDown()
                  : iosPicker()
          ),
        ],
      ),
    );
  }
}

// Novo Re-usable Widget
class CryptoCard extends StatelessWidget {
  // Atributos
  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;
  
  // Construtor
  const CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

