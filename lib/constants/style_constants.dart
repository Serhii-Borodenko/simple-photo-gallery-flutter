import 'package:flutter/material.dart';

const BoxDecoration customGradientBackground = BoxDecoration(
  gradient: LinearGradient(
      colors: [Color(0xff1c92d2), Color(0xfff2fcfe)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft),
);

BoxDecoration widgetsContainerStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Colors.white70,
);
