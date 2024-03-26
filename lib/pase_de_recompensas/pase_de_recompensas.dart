import 'package:flutter/material.dart';

class PaseDeRecompensas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= 10; i++)
          Expanded(
            child: Column(
              children: [
                Text('$i'),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  // Insert your photo widget here
                ),
              ],
            ),
          ),
      ],
    );
  }
}