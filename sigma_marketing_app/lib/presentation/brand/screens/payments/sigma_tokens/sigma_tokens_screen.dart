import 'dart:ui';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/brand/sigma_tokens/sigma_tokens_bloc.dart';

import '../../../../../services/paypal_service.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../model/sigma_token_model.dart';

class SigmaTokensScreen extends StatefulWidget {
  const SigmaTokensScreen({Key? key}) : super(key: key);

  @override
  _SigmaTokensScreenState createState() => _SigmaTokensScreenState();
}

class _SigmaTokensScreenState extends State<SigmaTokensScreen> {
  late SigmaTokenModel selectedItem;

  PaypalService services = PaypalService();
  String returnURL = 'https://youtube.com';
  String cancelURL = 'https://www.youtube.com/watch?v=w3HC1dkkqnY';

  @override
  void initState() {
    super.initState();
    selectedItem = SigmaTokenModel(
        id: 0,
        packageName: '',
        price: 0,
        amount: 0,
        isSelected: false,
        checkoutUrl: '',
        executeUrl: '',
        accessToken: '',
        package: {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SigmaTokensBloc()..add(SigmaTokensFetched()),
        child: BlocBuilder<SigmaTokensBloc, SigmaTokensState>(
            builder: (context, state) {
          if (state.status == SigmaTokensStatus.failure) {
            return _buildErrorScreen();
          }
          if (state.status == SigmaTokensStatus.initial) {
            return _buildLoadingScreen();
          }

          // Purchase states
          if (state.status == SigmaTokensStatus.purchasing) {
            return _buildPurchasingScreen();
          }
          if(state.status == SigmaTokensStatus.purchasedFailure){
            return _buildPurchaseErrorScreen();
          }
          if(state.status == SigmaTokensStatus.purchased){
            _closeDialog(context, true);
          }

          // Default show sigma tokens
          if (state.status == SigmaTokensStatus.success) {
            if (state.sigmaTokens.isNotEmpty) {
              selectedItem = state.sigmaTokens.firstWhere(
                  (element) => element.isSelected == true,
                  orElse: () => SigmaTokenModel(
                      id: 0,
                      packageName: '',
                      price: 0,
                      amount: 0,
                      isSelected: false,
                      checkoutUrl: '',
                      executeUrl: '',
                      accessToken: '',
                      package: {}));
            }
          }
          return Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.sigmaTokens.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (var item in state.sigmaTokens) {
                                    item.isSelected = false;
                                  }
                                  state.sigmaTokens[index].isSelected = true;
                                  selectedItem = state.sigmaTokens[index];
                                });
                              },
                              child: Container(
                                color: state.sigmaTokens[index].isSelected
                                    ? SMColors.main.withOpacity(0.8)
                                    : Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Image(
                                              image: AssetImage(
                                                  'assets/sigma_token.png')),
                                          const SizedBox(width: 10),
                                          Text(
                                              '${state.sigmaTokens[index].amount}'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.attach_money),
                                            Text(
                                                '${state.sigmaTokens[index].price}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final webview = await WebviewWindow.create(
                            configuration: const CreateConfiguration(
                              title: "Buy Sigma Tokens PayPal",
                              titleBarTopPadding: 0,
                              titleBarHeight: 0,
                            ),
                          );

                          webview.addOnUrlRequestCallback((url) async {
                            if (url.contains(returnURL)) {
                              webview.close();
                              final purchase = await services.executePayment(
                                  Uri.parse(selectedItem.executeUrl),
                                  selectedItem.package,
                                  selectedItem.accessToken);

                              if (purchase != null) {
                                BlocProvider.of<SigmaTokensBloc>(context).add(
                                    PurchaseTokensEvent(purchase: purchase));
                              }
                            }

                            if (url.contains(cancelURL)) {
                              // show some error or cancel
                            }
                          });

                          webview.launch(selectedItem.checkoutUrl);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: SMColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                        ),
                        child: Text('Buy ${selectedItem.amount} Sigma Tokens'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void _closeDialog(BuildContext context, bool result) {
    Navigator.of(context).pop(result); // Pass the result back to the parent
  }

  Dialog _buildErrorScreen() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.2),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child:
                      Center(child: Text('failed to fetch sigma tokens')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Dialog _buildLoadingScreen() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.2),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Loading Packages...')
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Dialog _buildPurchasingScreen() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.2),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text('Don\'t close window, purchasing token in progress...')
                          ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Dialog _buildPurchaseErrorScreen() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.2),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child:
                  Center(child: Text('Failed to buy sigma tokens, try again! If something is not right, contact us!')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
