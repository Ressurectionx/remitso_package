import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryProvider with ChangeNotifier {
  List<Country> _countries = [];
  Country? _selectedCountry;

  List<Country> get countries => _countries;
  Country? get selectedCountry => _selectedCountry;

  void setCountries(List<Country> countries) {
    _countries = countries;
    notifyListeners();
  }

  void selectCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
