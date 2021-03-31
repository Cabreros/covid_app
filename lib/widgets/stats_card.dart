import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xff41b3a3),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Active Cases',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontFamily: 'Futura',
              ),
            ),
            Text(
              '25744',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Futura',
              ),
            )
          ],
        ),
      ),
    );
  }
}
