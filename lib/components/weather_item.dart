import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final int value;

  final String unit;
  final String imageUrl;

  const WeatherItem({
    super.key,
    required this.value,
    required this.unit,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            width: 60,
            child: Image.asset(imageUrl),
          ),
          Text(
            value.toString() + unit,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}
