import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';
import 'package:sigma_marketing/config/constants.dart';
import 'package:sigma_marketing/data/models/request/payment/purchase.dart';

class PaypalService {
  String domain = AppConstants.paypalDomain;

  // for getting the access token from Paypal
  Future<String?> getAccessToken() async {
    try {
      var client = BasicAuthClient(
        AppConstants.paypalClientId,
        AppConstants.paypalSecret,
      );
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>?> createPaypalOrder(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v2/checkout/orders"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String selfUrl = "";
          String approveUrl = "";
          String updateUrl = "";
          String captureUrl = "";

          // Find the "self" link
          final selfLink = links.firstWhere(
            (o) => o["rel"] == "self",
            orElse: () => null,
          );

          // Find the "approve" link
          final approveLink = links.firstWhere(
            (o) => o["rel"] == "approve",
            orElse: () => null,
          );

          // Find the "update" link
          final updateLink = links.firstWhere(
            (o) => o["rel"] == "update",
            orElse: () => null,
          );

          // Find the "capture" link
          final captureLink = links.firstWhere(
            (o) => o["rel"] == "capture",
            orElse: () => null,
          );

          if (selfLink != null) {
            selfUrl = selfLink["href"];
          }
          if (approveLink != null) {
            approveUrl = approveLink["href"];
          }
          if (updateLink != null) {
            updateUrl = updateLink["href"];
          }
          if (captureLink != null) {
            captureUrl = captureLink["href"];
          }

          return {"executeUrl": approveUrl, "approvalUrl": captureUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<Purchase?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode(payerId),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        final id = body["id"];
        final payerId = body["payer"]["payer_id"];
        //final name = body["purchase_units"][0]["items"][0]["name"];
        final name = "Sigma50";

        final purchase = Purchase(orderId: id, package: name, payerId: payerId);
        return purchase;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
