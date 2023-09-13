import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';
import 'package:sigma_marketing/presentation/user/screens/profile/payments/transactions.dart';
import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/request/payment/paypal_email.dart';
import '../../../../../data/models/request/payment/withdraw.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/user/payments_user/payments_user_bloc.dart';
import '../../../../common/widgets/custom_text_input/custom_text_input.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  late PaymentsUserBloc _paymentsUserBloc;
  late TextEditingController _paypalEmailController;

  @override
  void initState() {
    super.initState();
    _paypalEmailController = TextEditingController();
    _paymentsUserBloc = PaymentsUserBloc();
    _paymentsUserBloc.add(PaymentsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: SMColors.secondMain,
      appBar: AppBar(
        backgroundColor: SMColors.main,
        title: const Text("Payments"),
      ),
      body: BlocBuilder<PaymentsUserBloc, PaymentsUserState>(
        bloc: _paymentsUserBloc,
        builder: (context, state) {
          switch (state.status) {
            case PaymentsUserStatus.failure:
              return const Center(child: Text('failed to fetch payments'));
            case PaymentsUserStatus.success:
              if (state.paymentUser.payments.isEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeaderWithBalance(state.paymentUser.balance,
                          state.paymentUser.paypalEmail),
                      _buildPaypalEmailCard(state.paymentUser.paypalEmail),
                      const SizedBox(height: 16),
                      const Center(child: Text('no transactions')),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                  child: Column(children: [
                _buildHeaderWithBalance(
                    state.paymentUser.balance, state.paymentUser.paypalEmail),
                _buildPaypalEmailCard(state.paymentUser.paypalEmail),
                const SizedBox(height: 16),
                Transactions(payments: state.paymentUser.payments),
              ]));
            case PaymentsUserStatus.withdrawal:
              return _buildWithdrawRequested();
            case PaymentsUserStatus.withdrawalSuccess:
              return _buildWithdrawSuccess();
            case PaymentsUserStatus.withdrawalFailure:
              return _buildWithdrawFailure();
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPaypalEmailCard(String email) {
    var emailDialog = "";
    var style = CustomTextStyle.regularText(14);

    if (email.isNotEmpty) {
      emailDialog = email;
      style = CustomTextStyle.semiBoldText(18);
    }

    if (email.isEmpty) email = "Please add your paypal email!";

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.thirdMain, // Background color
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Row(
            children: [
              CustomLabel(title: "Paypal"),
              SizedBox(width: 16),
              Image(
                  image: AssetImage("assets/paypal.png"),
                  width: 32,
                  height: 32),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            color: SMColors.borderColor,
            thickness: 1,
          ),
          const SizedBox(height: 8),
          const CustomLabel(title: "Your Paypal email"),
          const SizedBox(height: 8),
          Text(email, style: style),
          const SizedBox(height: 8),
          CustomButton(
              text: "Edit",
              onPressed: () {
                _paypalEmailDialog(emailDialog);
              }),
        ],
      ),
    );
  }

  void _paypalEmailDialog(String currentEmail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController emailController = TextEditingController();
        emailController.text = currentEmail;

        return AlertDialog(
          backgroundColor: SMColors.thirdMain,
          title: Text("Paypal Email", style: CustomTextStyle.boldText(18)),
          content: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInput(
                  labelText: "Enter email",
                  hintText: "Enter your PayPal email address",
                  controller: emailController,
                  validator: (email) {
                    if (emailController.text.isEmpty) {
                      return "Please enter your PayPal email address";
                    }
                    return email;
                  }),
            ],
          )),
          actions: [
            CustomButton(
                text: "Save",
                onPressed: () {
                  final paypalEmail =
                      PaypalEmail(paypalEmail: emailController.text);
                  _paymentsUserBloc.add(PaypalEmailUpdateEvent(paypalEmail));
                  Navigator.of(context).pop();
                }),
            CustomButton(
                text: "Cancel",
                backgroundColor: SMColors.clearButton,
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  Widget _buildWithdrawRequested() {
    return _buildMessageUI(
      "Transaction is being processed",
      "Please wait and don't close the app",
      const CircularProgressIndicator(),
    );
  }

  Widget _buildWithdrawSuccess() {
    return _buildMessageUI(
        "Transaction completed successfully",
        "Please check your PayPal account",
        CustomButton(
            text: "Refresh",
            onPressed: () {
              _paymentsUserBloc.add(PaymentsFetched());
            }));
  }

  Widget _buildWithdrawFailure() {
    return _buildMessageUI(
      "Transaction failed",
      "Please contact support and try again later.",
      CustomButton(
          text: "Try again",
          onPressed: () {
            _paymentsUserBloc.add(PaymentsFetched());
          }),
    );
  }

  Widget _buildMessageUI(String title, String message, Widget actionButton) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: CustomTextStyle.boldText(20),
          ),
          const SizedBox(height: 16),
          Text(message, style: CustomTextStyle.regularText(18)),
          const SizedBox(height: 16),
          actionButton,
        ],
      ),
    );
  }

  Widget _buildHeaderWithBalance(int balance, String paypalEmail) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.thirdMain, // Background color
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text("Balance:", style: CustomTextStyle.boldText(16)),
              const SizedBox(width: 16),
              Text(
                balance.toString(),
                style: CustomTextStyle.boldText(24),
              ),
              const SizedBox(width: 16),
              const Image(
                  image: AssetImage("assets/sigma_token.png"),
                  width: 24,
                  height: 24),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            color: SMColors.borderColor,
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "${(balance * 0.9).toStringAsFixed(2)} \$",
                    style: CustomTextStyle.boldText(16),
                  )),
              CustomButton(
                  text: "Withdraw",
                  onPressed: paypalEmail.isNotEmpty
                      ? () {
                          _withdrawDialog(balance);
                        }
                      : null),
              const SizedBox(width: 8),
              Visibility(
                  visible: paypalEmail.isEmpty,
                  child: const Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: "Please add valid paypal email!",
                      child: Icon(Icons.warning_amber, size: 24))),
            ],
          )
        ],
      ),
    );
  }

  void _withdrawDialog(int balance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int currentBalance = balance;
        int withdrawalAmount = 20;
        TextEditingController amountController = TextEditingController();

        return AlertDialog(
          backgroundColor: SMColors.thirdMain,
          title: Text("Withdraw", style: CustomTextStyle.boldText(18)),
          content: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Sigma Tokens will be converted to dollars \$ and sent to your PayPal account.",
                style: CustomTextStyle.regularText(16),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Text("Current Balance: ${currentBalance.toString()}",
                    style: CustomTextStyle.semiBoldText(16)),
                const SizedBox(width: 8),
                const Image(
                    image: AssetImage("assets/sigma_token.png"),
                    width: 24,
                    height: 24),
              ]),
              const SizedBox(height: 16),
              CustomTextInput(
                  labelText: "Enter amount",
                  hintText: "Enter amount, minimum is 20",
                  controller: amountController,
                  validator: null),
            ],
          )),
          actions: [
            CustomButton(
                text: "Withdraw",
                onPressed: () {
                  withdrawalAmount = int.parse(amountController.text);
                  if (withdrawalAmount >= 20) {
                    final withdraw =
                        Withdraw(amount: withdrawalAmount, paypalEmail: "");
                    _paymentsUserBloc.add(WithdrawalRequested(withdraw));
                    Navigator.of(context).pop();
                  } else {
                    // Display an error or toast message
                  }
                }),
            CustomButton(
                text: "Cancel",
                backgroundColor: SMColors.clearButton,
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
