import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:traelling_app/costanse/colors.dart';

class Posters extends StatefulWidget {
  const Posters({super.key});

  @override
  State<Posters> createState() => _PostersState();
}

class _PostersState extends State<Posters> {
  Query dreamB = FirebaseDatabase.instance.ref().child('post');

  Widget contanerImage() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: hight * 0.40,
        width: width * 0.90,
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.black),
            color: MyColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: FirebaseAnimatedList(
            query: dreamB,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map smap = snapshot.value as Map;
              smap['key'] = snapshot.key;
              return Image.network(smap['$snapshot']);
            },
          ),
        ),
      ),
    );
  }

  Widget Myproducts({required Map smap}) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          contanerImage(),
          SizedBox(
            height: hight * 0.02,
          ),
          Text(smap['title'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("order page "),
          ),
          body: const Column(
            children: [],
          )),
    );
  }
}
