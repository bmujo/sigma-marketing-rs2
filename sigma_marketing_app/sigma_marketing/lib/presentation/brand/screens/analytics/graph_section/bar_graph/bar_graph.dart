import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

class MyBarGraph extends StatefulWidget {
  final List<int> listNumberOfApplications;

  const MyBarGraph(this.listNumberOfApplications, {Key? key}) : super(key: key);

  @override
  _MyBarGraphState createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  int maxNumber = 100;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.listNumberOfApplications.reduce((a, b) => a > b ? a : b) + 5;
  }

  @override
  Widget build(BuildContext context) {
    final barGroups = widget.listNumberOfApplications.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: 0,
            color: Colors.white,
            toY: value.toDouble(),
            width: 8,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        maxY: maxNumber.toDouble(),
        minY: 0,
        borderData: FlBorderData(
          show: false,
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            axisNameWidget: Text(
              "Number of applications",
              style: CustomTextStyle.regularText(10),
            ),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              "Campaigns",
              style: CustomTextStyle.regularText(10),
            ),
          ),
        ),
        barGroups: barGroups,
      ),
    );
  }
}
