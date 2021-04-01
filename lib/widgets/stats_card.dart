import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String label;
  final int stat;
  final Color color;
  const StatsCard({
    @required this.label,
    @required this.stat,
    this.color: const Color(0xff41b3a3),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontFamily: 'Futura',
              ),
            ),
            Text(
              '$stat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Futura',
              ),
            )
          ],
        ),
      ),
    );
  }
}
