import 'package:flutter/material.dart';

class TabBrows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Browse Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }}