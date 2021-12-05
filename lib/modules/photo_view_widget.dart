import 'package:flutter/material.dart';

class PhotoViewWidget extends StatelessWidget {
  const PhotoViewWidget({
    Key? key,
    this.imageProvider,
  }) : super(key: key);
  final imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 20.0),
        child: Container(
          constraints: const BoxConstraints.expand(width: double.infinity),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
