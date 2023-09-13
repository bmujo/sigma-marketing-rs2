import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma_marketing/blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_status/custom_status.dart';

import '../../../../../data/models/response/base/base_status.dart';

class TableDataSource extends DataTableSource {
  final BuildContext context;
  final CampaignAnalyticsState campaignAnalyticsState;

  TableDataSource(this.context, this.campaignAnalyticsState);

  @override
  DataRow getRow(int index) {
    if (campaignAnalyticsState.status == CampaignAnalyticsStatus.success) {
      try {
        final data = campaignAnalyticsState.campaigns[index];

        return DataRow.byIndex(
          index: index,
          cells: [
            buildDataCell(data.name),
            buildDateCell(data.start),
            buildDateCell(data.end),
            buildDataCell(data.budget.toString()),
            buildDataCell(data.numberOfApplications.toString()),
            buildDataCell(data.numberOfParticipants.toString()),
            buildDataCell(data.engagementRate.toString()),
            buildDataCell(data.ROI.toString()),
            buildStatusDataCell(data.status),
          ],
        );
      } catch (e) {
        return DataRow.byIndex(
          index: index,
          cells: [],
        );
      }
    } else {
      return DataRow.byIndex(
        index: index,
        cells: [],
      );
    }
  }

  buildDataCell(String text) {
    return DataCell(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.center,
          child: Text(text),
        ),
      ),
      onTap: () {
        // Handle cell tap if needed
      },
    );
  }

  buildStatusDataCell(BaseStatus status) {
    return DataCell(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Align(
          alignment: Alignment.center,
          child: CustomStatus(status: status),
        ),
      ),
      onTap: () {
        // Handle cell tap if needed
      },
    );
  }

  buildDateCell(DateTime date) {
    return DataCell(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Align(
          alignment: Alignment.center,
          child: Text(DateFormat('dd.MM.yyy HH:mm').format(date)),
        ),
      ),
      onTap: () {
        // Handle cell tap if needed
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => campaignAnalyticsState.campaignAnalytics!.total;

  @override
  int get selectedRowCount => 0;
}
