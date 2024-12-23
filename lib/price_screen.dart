import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cards.dart';
import './coin_data.dart';
import 'dart:io' show Platform;
import 'api.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedNewValue = 'USD';
  String marketDataBTC = '';
  String marketDataETH = '';
  String marketDataLTC = '';

  GetApi getApi = GetApi();

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: selectedNewValue,
      iconDisabledColor: Colors.white,
      iconEnabledColor: Colors.white,
      items: currenciesList
          .map((String e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(
                      color: Colors.white), // Color del texto en blanco
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedNewValue = value!;
        });
        fetchData(selectedNewValue, 'BTC');
        fetchData(selectedNewValue, 'ETH');
        fetchData(selectedNewValue, 'LTC');
      },
      dropdownColor: blueColor, // Color de fondo del menú desplegable
      style:
          const TextStyle(color: Colors.white), // Color del texto seleccionado
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: blueColor,
      itemExtent: 32.0,
      onSelectedItemChanged: (int index) {
        String selectedCurrency = currenciesList[index];

        setState(() {
          selectedNewValue = selectedCurrency;
        });

        fetchData(selectedNewValue, 'BTC');
        fetchData(selectedNewValue, 'ETH');
        fetchData(selectedNewValue, 'LTC');
      },
      children: currenciesList
          .map((String e) => Text(
                e,
                style: const TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }

  Widget getPicker() {
    if (Platform.isAndroid) {
      return androidDropdown();
      // } else if (Platform.isIOS) {
      //   return iOSPicker();
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(selectedNewValue, 'BTC');
    fetchData(selectedNewValue, 'ETH');
    fetchData(selectedNewValue, 'LTC');
  }

  Future<void> fetchData(String idQuote, idBase) async {
    final data = await getApi.getApiData(idQuote, idBase);

    if (data != null) {
      setState(() {
        double rate = data['rate'];

        if (idBase == 'BTC') {
          marketDataBTC = '1 $idBase = ${rate.toStringAsFixed(2)} $idQuote';
        } else if (idBase == 'ETH') {
          marketDataETH = '1 $idBase = ${rate.toStringAsFixed(2)} $idQuote';
        } else if (idBase == 'LTC') {
          marketDataLTC = '1 $idBase = ${rate.toStringAsFixed(2)} $idQuote';
        }

        print(marketDataBTC);
        print(marketDataETH);
        print(marketDataLTC);
      });
    } else {
      print('No hay data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      appBar: AppBar(
        title: const Text(
          'Coin Ticker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: blueColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Card(
                  color: blueColor,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$marketDataBTC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Card(
                  color: blueColor,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$marketDataETH',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Card(
                  color: blueColor,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$marketDataLTC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100.0,
            width: double.infinity,
            alignment: Alignment.center,
            color: blueColor,
            child: getPicker(),
          ),
        ],
      )),
    );
  }
}
