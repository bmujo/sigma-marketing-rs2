import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_analytics/platform_item.dart';

import '../../../../../../utils/colors/colors.dart';
import 'indicator.dart';

class MyPieChart extends StatefulWidget {
  final List<PlatformItem> platforms;

  const MyPieChart({Key? key, required this.platforms}) : super(key: key);

  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [SMColors.cardLinearStart, SMColors.cardLinearEnd],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Platforms",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: SMColors.white,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 10,
                      sections: showingSections(widget.platforms),
                    ),
                  ),
                ),
                _buildLegend(widget.platforms)
              ],
            )),
          ]),
    );
  }

  Widget _buildLegend(List<PlatformItem> platforms) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Vertical scrolling
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: platforms.map((platform) {
          return Column(
            children: [
              Indicator(
                color: SMColors.secondMain,
                text: platform.name,
                isSquare: false,
                size: touchedIndex == platforms.indexOf(platform) ? 16 : 12,
              ),
              const SizedBox(height: 4),
            ],
          );
        }).toList(),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<PlatformItem> platforms) {
    return platforms.asMap().entries.map((entry) {
      final index = entry.key;
      final platform = entry.value;

      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 12.0 : 8.0;
      final radius = isTouched ? 80.0 : 60.0;

      return PieChartSectionData(
        color: SMColors.secondMain,
        value: platform.percentage.toDouble(),
        title: '${platform.percentage}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: SMColors.white,
        ),
      );
    }).toList();
  }
}
