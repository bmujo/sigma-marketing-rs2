import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/brand/payments/payments_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/payments/history_table/history_table.dart';
import 'package:sigma_marketing/presentation/brand/screens/payments/sigma_tokens/sigma_tokens_screen.dart';

import '../../../../config/style/custom_text_style.dart';
import '../../../../utils/colors/colors.dart';

class PaymentsDesktopScreen extends StatefulWidget {
  const PaymentsDesktopScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const PaymentsDesktopScreen());
  }

  @override
  _PaymentsDesktopScreenState createState() => _PaymentsDesktopScreenState();
}

class _PaymentsDesktopScreenState extends State<PaymentsDesktopScreen> {
  int? selectedActiveCampaignIndex;
  late PaymentsBloc _paymentsBloc;

  @override
  void initState() {
    super.initState();
    _paymentsBloc = PaymentsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _paymentsBloc..add(PaymentsFetched()),
        child:
            BlocBuilder<PaymentsBloc, PaymentsState>(builder: (context, state) {
          if (state.status == PaymentsStatus.initial) {
            return _buildLoadingScreen();
          }
          if (state.status == PaymentsStatus.failure) {
            return Center(
                child: Text(
              'Something went wrong',
              style: CustomTextStyle.semiBoldText(16),
            ));
          }

          return Scaffold(
            backgroundColor: SMColors.main,
            body: Column(
              children: [
                buildBalanceAndBuy(state.paymentBrand.balance),
                HistoryTable(dataList: state.paymentBrand.payments)
              ],
            ),
          );
        }));
  }

  Scaffold _buildLoadingScreen() {
    return Scaffold(
        backgroundColor: SMColors.main,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    Text(
                      'Loading Payments...',
                      style: CustomTextStyle.boldText(16),
                    ),
                  ])),
            ),
          ],
        ));
  }

  Padding buildBalanceAndBuy(int balance) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            buildBuy(),
            const SizedBox(width: 32),
            buildBalance(balance),
            // Two cards with numbers
          ],
        ));
  }

  Padding buildBalance(int balance) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Current balance: ',
                style: CustomTextStyle.semiBoldText(14),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Image(image: AssetImage('assets/sigma_token.png')),
                const SizedBox(width: 8),
                Text(
                  balance.toString(),
                  style: CustomTextStyle.semiBoldText(20),
                )
              ],
            ),
          ],
        ),
      ),
      // Additional content for the second container
    );
  }

  GestureDetector buildBuy() {
    return GestureDetector(
      onTap: () async {
        bool result = await showDialog(
          context: context,
          builder: (context) => SigmaTokensScreen(),
        );

        if (result) {
          _paymentsBloc.add(PaymentsFetched());

          // show toast message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sigma tokens purchased successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
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
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.compare_arrows_rounded,
                    color: SMColors.white,
                    size: 60,
                  ),
                  SizedBox(width: 16),
                  //Network image of paypall
                  Image(image: AssetImage('assets/paypal.png')),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buy Sigma Tokens',
                      style: TextStyle(
                        color: SMColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
