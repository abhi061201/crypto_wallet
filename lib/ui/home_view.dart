// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../net/api_methods.dart';
import 'add_view.dart';

// if login succesful we will directed to homepage,
class Homeview extends StatefulWidget {
  const Homeview({Key? key}) : super(key: key);

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  double bitcoin = 0.0;
  double etherium = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    etherium = await getPrice("etherium");
    tether = await getPrice("tether");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValues(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "etherium") {
        return etherium * amount;
      } else if (id == "tether") {
        return tether * amount;
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('Coins')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  final val=document.data() as Map;
                    double amount= val['Amount'];
                  return Container(
                      width:MediaQuery.of(context).size.width/1.3,
                      height: MediaQuery.of(context).size.height/12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // for current price of dollor we need to implement the function for that
                        Text(
                          "CoinName : ${document.id}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Amount Owned : \$${getValues(document.id, amount)!.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      // button on screen to add the coins.
      floatingActionButton: FloatingActionButton(
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
