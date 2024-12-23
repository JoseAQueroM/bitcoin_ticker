import 'package:flutter/material.dart';


const blueColor = Color.fromARGB(255, 26, 102, 138);

class CardCoin extends StatefulWidget {
  const CardCoin({super.key});

  @override
  State<CardCoin> createState() => _CardCoinState();
}

class _CardCoinState extends State<CardCoin> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: const Card(
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
                              Text('1 BTC = ? USD',
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
            );
  }
}