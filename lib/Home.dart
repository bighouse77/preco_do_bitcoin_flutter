// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _valor = "R\$ 0.00";

  void buscarValor() async {
    String url = "https://blockchain.info/ticker";

    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _valor = "R\$ ${retorno["BRL"]["buy"]}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                _valor,
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: Text(
                      "Atualizar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  color: Colors.orange,
                  onPressed: buscarValor),
            )
          ],
        ),
      ),
    );
  }
}
