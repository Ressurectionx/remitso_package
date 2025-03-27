import 'country_model.dart';
import 'currency_model.dart';

class ExchangeRateModel {
  final double localAmount;
  final double foreignAmount;
  final double? exchangeRate;
  final double baseFees;
  final Country? paymentCountry;
  final Currency? paymentCurrency;
  final Country? payoutCountry;
  final Currency? payoutCurrency;

  ExchangeRateModel({
    required this.localAmount,
    required this.foreignAmount,
    this.exchangeRate,
    required this.baseFees,
    this.paymentCountry,
    this.paymentCurrency,
    this.payoutCountry,
    this.payoutCurrency,
  });
}
