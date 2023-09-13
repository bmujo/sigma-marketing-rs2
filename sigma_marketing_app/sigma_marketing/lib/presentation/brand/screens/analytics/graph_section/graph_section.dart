import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/analytics/graph_section/pie_chart/pie_chart.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../utils/colors/colors.dart';
import 'bar_graph/bar_graph.dart';

class GraphSection extends StatefulWidget {
  const GraphSection({Key? key}) : super(key: key);

  @override
  _GraphSectionState createState() => _GraphSectionState();
}

class _GraphSectionState extends State<GraphSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignAnalyticsBloc, CampaignAnalyticsState>(
        builder: (context, state) {
      if (state.status == CampaignAnalyticsStatus.success) {
        return Container(
          decoration: const BoxDecoration(
            color: SMColors.main, // Background color
            border: Border(
              bottom: BorderSide(
                color: SMColors.borderColor,
                width: 1.0,
              ),
              left: BorderSide(
                color: SMColors.borderColor,
                width: 1.0,
              ),
            ),
          ),
          height: 250,
          child: Row(
            children: [
              _buildVerticalStackBarChart(
                  state.campaignAnalytics!.listNumberOfApplications),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      MyPieChart(platforms: state.campaignAnalytics!.platforms),
                      _buildNumberCards(
                        state.campaignAnalytics!.total,
                        state.campaignAnalytics!.finishedCampaignsCount,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (state.status == CampaignAnalyticsStatus.failure) {
        return const Text('Error loading data');
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Expanded _buildVerticalStackBarChart(List<int> listNumberOfApplications) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
        child: Container(
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
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 16, bottom: 8, right: 8),
            child: MyBarGraph(listNumberOfApplications),
          ),
        ),
      ),
    );
  }

  Expanded _buildNumberCards(int total, int finished) {
    return Expanded(
      flex: 5,
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
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
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Number of campaigns',
                        style: CustomTextStyle.mediumText(14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        total.toString(),
                        style: CustomTextStyle.mediumText(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        SMColors.cardLinearStart,
                        SMColors.cardLinearEnd
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Finished campaigns',
                          style: CustomTextStyle.mediumText(14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          finished.toString(),
                          style: CustomTextStyle.mediumText(20),
                        )
                      ],
                    ),
                  ),
                  // Additional content for the second container
                ),
              ),
            ),
            // Two cards with numbers
          ],
        ),
      ),
    );
  }
}
