import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  final int index;
  const ViewScreen({Key? key, required this.index, required this.snapshot})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Hero(
              tag: 'logo$index',
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data!.docs[0].get('$index'),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors
                        .lightBlueAccent, //change background color of button
                    onPrimary: Colors.white),
                onPressed: () {},
                label: const Text(
                  'Share',
                  style: TextStyle(fontSize: 20.0),
                ),
                icon: const Icon(Icons.share),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
