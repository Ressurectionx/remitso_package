import 'package:flutter/material.dart';
import '../models/exchange_rate_model.dart';

class RateCalculatorProvider with ChangeNotifier {
  ExchangeRateModel _exchangeRateModel;

  RateCalculatorProvider(this._exchangeRateModel);

  ExchangeRateModel get exchangeRateModel => _exchangeRateModel;

  void updateLocalAmount(double amount) {
    _exchangeRateModel = ExchangeRateModel(
      localAmount: amount,
      foreignAmount: _exchangeRateModel.foreignAmount,
      exchangeRate: _exchangeRateModel.exchangeRate,
      baseFees: _exchangeRateModel.baseFees,
      paymentCountry: _exchangeRateModel.paymentCountry,
      paymentCurrency: _exchangeRateModel.paymentCurrency,
      payoutCountry: _exchangeRateModel.payoutCountry,
      payoutCurrency: _exchangeRateModel.payoutCurrency,
    );
    notifyListeners();
  }

  void updateForeignAmount(double amount) {
    _exchangeRateModel = ExchangeRateModel(
      localAmount: _exchangeRateModel.localAmount,
      foreignAmount: amount,
      exchangeRate: _exchangeRateModel.exchangeRate,
      baseFees: _exchangeRateModel.baseFees,
      paymentCountry: _exchangeRateModel.paymentCountry,
      paymentCurrency: _exchangeRateModel.paymentCurrency,
      payoutCountry: _exchangeRateModel.payoutCountry,
      payoutCurrency: _exchangeRateModel.payoutCurrency,
    );
    notifyListeners();
  }
}
