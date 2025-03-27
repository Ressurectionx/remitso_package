import '../../styles/styles.dart';
import '../../styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/country_model.dart';
import '../../models/currency_model.dart';
import '../../models/exchange_rate_model.dart';
import '../../providers/rate_calculator_provider.dart';



class RateCalculator extends StatelessWidget {
  final Function(double)? onSendAmountChanged;
  final Function(double)? onReceiveAmountChanged;
  final Function(Country, Currency)? onCountryChanged;

  const RateCalculator({
    super.key,
    this.onSendAmountChanged,
    this.onReceiveAmountChanged,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RateCalculatorProvider>(
      builder: (context, provider, child) {
        final model = provider.exchangeRateModel;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSendInfo(context, model),
            Divider(color: AppColors.blueDivider),
            _buildTransactionFeesInfo(model),
            _buildConvertedAmountInfo(model),
            _buildExchangeRateInfo(model),
            Divider(color: AppColors.blueDivider),
            _buildReceiveInfo(context, model),
          ],
        );
      },
    );
  }

  Widget _buildSendInfo(BuildContext context, ExchangeRateModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildSendAmount(context, model),
          const Spacer(),
          VerticalDivider(color: AppColors.blueDivider),
          _buildCountryInfo(model.paymentCountry, model.paymentCurrency),
        ],
      ),
    );
  }

  Widget _buildSendAmount(BuildContext context, ExchangeRateModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("You Send", style: AppTextStyles.subHeader.copyWith(color: AppColors.white)),
        const SizedBox(height: 6),
        SizedBox(
          width: 230,
          child: TextField(
            controller: TextEditingController(text: model.localAmount.toString()),
            style: AppTextStyles.header.copyWith(color: AppColors.white),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefix: Text("${model.paymentCurrency?.iconUnicode} ", style: AppTextStyles.header.copyWith(color: AppColors.white)),
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              double? amount = double.tryParse(value);
              if (amount != null) {
                onSendAmountChanged?.call(amount);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionFeesInfo(ExchangeRateModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _buildInfoRow("assets/icons/plus.svg", "£${model.baseFees}", "Transaction fees"),
    );
  }

  Widget _buildConvertedAmountInfo(ExchangeRateModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _buildInfoRow("assets/icons/right_arrow.svg", "£${model.localAmount}", "Converted amount"),
    );
  }

  Widget _buildExchangeRateInfo(ExchangeRateModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _buildInfoRow("assets/icons/cancel.svg", model.exchangeRate?.toString() ?? "0.00", "Exchange rate"),
    );
  }

  Widget _buildInfoRow(String path, String value, String title) {
    return Row(
      children: [
        Column(
          children: [
            Container(height: 12, width: 0.5, color: AppColors.background),
            Image.asset(path),
            Container(height: 12, width: 0.5, color: AppColors.background),
          ],
        ),
        const SizedBox(width: 10),
        Text(value, style: AppTextStyles.inputText.copyWith(color: AppColors.white), textAlign: TextAlign.end),
        const Expanded(child: SizedBox()),
        Text(title, style: AppTextStyles.inputText.copyWith(color: AppColors.white)),
      ],
    );
  }

  Widget _buildReceiveInfo(BuildContext context, ExchangeRateModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildReceiveAmount(context, model),
          const Spacer(),
          VerticalDivider(color: AppColors.blueDivider),
          GestureDetector(
            onTap: () {
              // Handle country change
            },
            child: _buildCountryInfo(model.payoutCountry, model.payoutCurrency),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiveAmount(BuildContext context, ExchangeRateModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("They Receive", style: AppTextStyles.subHeader.copyWith(color: AppColors.white)),
        const SizedBox(height: 6),
        SizedBox(
          width: 230,
          child: TextField(
            controller: TextEditingController(text: model.foreignAmount.toString()),
            style: AppTextStyles.header.copyWith(color: AppColors.white),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefix: Text("${model.payoutCurrency?.iconUnicode} ", style: AppTextStyles.header.copyWith(color: AppColors.white)),
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              double? amount = double.tryParse(value);
              if (amount != null) {
                onReceiveAmountChanged?.call(amount);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCountryInfo(Country? country, Currency? currency) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset("assets/images/flags/${country?.iso2Alpha?.toLowerCase()}.svg", width: 40, height: 40),
        ),
        const SizedBox(height: 5),
        Text(currency?.isoAlpha ?? "Select", style: AppTextStyles.subHeader.copyWith(color: AppColors.white)),
      ],
    );
  }
}
