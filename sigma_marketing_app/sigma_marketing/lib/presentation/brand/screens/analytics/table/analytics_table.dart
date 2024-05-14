import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/brand/screens/analytics/table/table_data_source.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';

class AnalyticsTable extends StatefulWidget {
  const AnalyticsTable({Key? key}) : super(key: key);

  @override
  _AnalyticsTableState createState() => _AnalyticsTableState();
}

class _AnalyticsTableState extends State<AnalyticsTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignAnalyticsBloc, CampaignAnalyticsState>(
        builder: (context, state) {
      if (state.status == CampaignAnalyticsStatus.success) {
        return Expanded(
            child: Container(
          decoration: const BoxDecoration(
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
            color: SMColors.main,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: SMColors.borderColor,
              cardTheme: const CardTheme(
                color: SMColors.main,
              ),
            ),
            child: PaginatedDataTable2(
              columnSpacing: 0,
              horizontalMargin: 0,
              wrapInCard: false,
              columns: [
                buildDataColumn('Name'),
                buildDataColumn('Start Date'),
                buildDataColumn('End Date'),
                buildDataColumn('Budget'),
                buildDataColumn('Num of Applications'),
                buildDataColumn('Num of Participants'),
                buildDataColumn('Engagement Rate'),
                buildDataColumn('ROI'),
                buildDataColumn('Status'),
              ],
              source: TableDataSource(context, state),
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              rowsPerPage: _rowsPerPage,
              empty: Center(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: const Text('No data'))),
              onPageChanged: (pageIndex) {
                context
                    .read<CampaignAnalyticsBloc>()
                    .add(CampaignAnalyticsFetched());
              },
              availableRowsPerPage: [5, 10],
              onRowsPerPageChanged: (newRowsPerPage) {
                setState(() {
                  _rowsPerPage =
                      newRowsPerPage ?? PaginatedDataTable.defaultRowsPerPage;
                });
              },
            ),
          ),
        ));
      } else if (state.status == CampaignAnalyticsStatus.failure) {
        return const Text('Error loading data');
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  DataColumn buildDataColumn(String name) {
    return DataColumn(
      label: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: SMColors.white,
              width: 2.0,
            ),
          ),
          color: SMColors.secondMain,
        ),
        child: Center(
          child: Text(
            name,
            style: CustomTextStyle.mediumText(14),
          ),
        ),
      ),
    );
  }
}
