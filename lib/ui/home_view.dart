// ignore_for_file: prefer_const_constructors

import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/ui/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../net/flutterfire.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double cardano = 0.0;
  double tether = 0.0;
  double dogecoin = 0.0;
  double solana = 0.0;
  double litecoin = 0.0;
  double polkadot = 0.0;
  double tron = 0.0;
  double chainlink = 0.0;

  @override
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    cardano = await getPrice("cardano");
    tether = await getPrice("tether");
    dogecoin = await getPrice("dogecoin");
    solana = await getPrice("solana");
    litecoin = await getPrice("litecoin");
    polkadot = await getPrice("polkadot");
    tron = await getPrice("tron");
    chainlink = await getPrice("chainlink");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValues(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else if (id == "cardano") {
        return cardano * amount;
      } else if (id == "tether") {
        return tether * amount;
      } else if (id == "dogecoin") {
        return dogecoin * amount;
      } else if (id == "solana") {
        return solana * amount;
      } else if (id == "litecoin") {
        return litecoin * amount;
      } else if (id == "polkadot") {
        return polkadot * amount;
      } else if (id == "tron") {
        return tron * amount;
      } else if (id == "chainlink") {
        return chainlink * amount;
      }
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF19B5FE),
          automaticallyImplyLeading: false,
          title: const Text('My NetWorth',
              style: TextStyle(
                color: Colors.white,
              ))),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF19B5FE),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 15, right: 15),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFF59ABE3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "${document.id}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                  "${getValues(document.id, document['Amount'])} Rs",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              IconButton(
                                onPressed: () async {
                                  await removeCoins(document.id);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ));
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF9b9bca),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
