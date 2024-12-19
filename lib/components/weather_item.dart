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
    // Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          // height: size.height * 0.1,
          // width: size.width * 0.2,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          value.toString() + unit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        )
      ],
    );
  }
}
