import 'package:flutter/material.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/payments/brand_payments.dart';

class HistoryTableDataSource extends DataTableSource {
  final BuildContext context;

  late final List<BrandPayments> dataList;

  HistoryTableDataSource(this.context, this.dataList);

  @override
  DataRow getRow(int index) {
    final data = dataList[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        buildDataCell(data.userFullName),
        buildDataCell(data.campaign),
        buildDataCell(data.type),
        buildDataCell(data.date),
        buildDataCell(data.time),
        buildDataCell(data.amount.toString()),
        buildDataCell(data.status),
      ],
    );
  }

  buildDataCell(String text) {
    return DataCell(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: CustomTextStyle.mediumText(12),
          ),
        ),
      ),
      onTap: () {},
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => 0;
}
