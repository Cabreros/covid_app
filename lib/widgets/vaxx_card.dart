import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VaxxCard extends StatelessWidget {
  final String label;
  final String stat;
  final Color color;
  final double percentage;
  const VaxxCard({
    @required this.label,
    @required this.stat,
    @required this.percentage,
    this.color: const Color(0xff41b3a3),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(
            height: 10.0,
          ),
          Text(
            '$stat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Futura',
            ),
          ),
          Center(
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 1000,
              percent: percentage,
              center: Text((percentage * 100).toStringAsFixed(2) + '%'),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
