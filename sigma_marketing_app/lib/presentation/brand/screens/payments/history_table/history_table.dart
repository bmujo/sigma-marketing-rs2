import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/brand/screens/payments/history_table/history_table_data_source.dart';

import '../../../../../../utils/colors/colors.dart';
import '../../../../../data/models/response/payments/brand_payments.dart';

class HistoryTable extends StatefulWidget {
  final List<BrandPayments> dataList;

  const HistoryTable({Key? key, required this.dataList}) : super(key: key);

  @override
  _HistoryTableState createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
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
          header: const Text('History of transactions'),
          columns: [
            buildDataColumn('Person'),
            buildDataColumn('Campaign'),
            buildDataColumn('Type'),
            buildDataColumn('Date'),
            buildDataColumn('Time'),
            buildDataColumn('Amount'),
            buildDataColumn('Status'),
          ],
          source: HistoryTableDataSource(context, widget.dataList),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          rowsPerPage: _rowsPerPage,
          empty: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  color: SMColors.main,
                  child: Text(
                    'No transactions',
                    style: CustomTextStyle.boldText(16),
                  ))),
          onPageChanged: (pageIndex) {
            // Handle page change if needed
          },
          onRowsPerPageChanged: (newRowsPerPage) {
            setState(() {
              _rowsPerPage =
                  newRowsPerPage ?? PaginatedDataTable.defaultRowsPerPage;
            });
          },
        ),
      ),
    ));
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
            style: CustomTextStyle.semiBoldText(14),
          ),
        ),
      ),
    );
  }
}
