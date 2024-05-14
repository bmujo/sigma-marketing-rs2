import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/analytics/graph_section/graph_section.dart';
import 'package:sigma_marketing/presentation/brand/screens/analytics/table/analytics_table.dart';
import 'filters/filters.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AnalyticsScreen());
  }

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int? selectedActiveCampaignIndex;
  CampaignAnalyticsBloc? _campaignAnalyticsBloc;


  @override
  void initState() {
    super.initState();
    _campaignAnalyticsBloc = CampaignAnalyticsBloc();
    _campaignAnalyticsBloc!.add(CampaignAnalyticsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CampaignAnalyticsBloc>(
      create: (_) => _campaignAnalyticsBloc!,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Filters(),
            GraphSection(),
            AnalyticsTable(),
          ],
        ),
      ),
    );
  }
}
