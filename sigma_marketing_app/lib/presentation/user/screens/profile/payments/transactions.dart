import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/payment_user/payment_user_item.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../common/widgets/custom_label/custom_label.dart';

class Transactions extends StatelessWidget {
  final List<PaymentUserItem> payments;

  const Transactions({required this.payments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: CustomLabel(title: "Transactions"),
        ),
        const Divider(
          color: SMColors.white,
          thickness: 2,
          indent: 16,
          endIndent: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: payments.length,
          itemBuilder: (context, index) {
            return PaymentListItem(payment: payments[index]);
          },
        ),
      ],
    );
  }
}

class PaymentListItem extends StatelessWidget {
  final PaymentUserItem payment;

  const PaymentListItem({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: SMColors.white,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                payment.type,
                style: CustomTextStyle.regularText(16),
              ),
              Visibility(
                  visible: payment.campaign.isNotEmpty,
                  child: Column(children: [
                    const SizedBox(height: 8),
                    Text(
                      payment.campaign,
                      style: CustomTextStyle.regularText(16),
                    ),
                  ]))
            ],
          ),
          Column(
            children: [
              Text(
                payment.status,
                style: CustomTextStyle.regularText(16),
              ),
              const SizedBox(height: 8),
              Text(
                "${payment.amount} / ${payment.price}\$",
                style: CustomTextStyle.semiBoldText(16),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                DateFormat('dd.MM.yyyy HH:mm').format(payment.date),
                style: CustomTextStyle.regularText(16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
