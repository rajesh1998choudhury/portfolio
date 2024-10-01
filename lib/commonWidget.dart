// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portfolio/Themes/colors.dart';

Widget buildGeneratedReportCard(
    String title, IconData leftIcon, IconData rightIcon) {
  return Container(
    width: 150,
    margin: const EdgeInsets.only(right: 8.0),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(leftIcon, size: 40, color: kIconColor),
              Icon(rightIcon, size: 40, color: Colors.white),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
