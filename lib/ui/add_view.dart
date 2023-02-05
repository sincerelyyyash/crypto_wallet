import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "ethereum",
    "cardano",
    "tether",
    "dogecoin",
    "solana",
    "litecoin",
    "polkadot",
    "tron",
    "chainlink",
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF19B5FE),
            title: const Text('Add your Coins',
                style: TextStyle(
                  color: Color(0xFF121222),
                ))),
        body: Container(
          color: Color(0xFF19B5FE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF59ABE3),
                ),
                child: Center(
                  child: DropdownButton(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    value: dropdownValue,
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value.toString();
                      });
                    },
                    items: coins.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(60),
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: "Coin Amount",
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFF59ABE3),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    await addCoin(dropdownValue, _amountController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ));
  }
}
