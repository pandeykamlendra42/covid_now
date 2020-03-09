import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class CountryPickerWidget extends StatelessWidget {
  final Function(String) callback;

  CountryPickerWidget({@required this.callback});

  static const Country GB = Country(
    asset: "assets/flags/default.png",
    dialingCode: "44",
    isoCode: "GB",
    name: "World",
    currency: "British pound",
    currencyISO: "world",
  );
  final _selected = ValueNotifier<Country>(GB);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: CustomAppTheme.primaryColor,
          border: Border.all(color: Colors.grey, width: 2)),
      child: ValueListenableBuilder(
        valueListenable: _selected,
        builder: (_, country, child) {
          return CountryPicker(
            nameTextStyle: TextStyle(color: Colors.white),
            dense: false,
            showFlag: true,
            showDialingCode: false,
            showName: true,
            showCurrency: false,
            showCurrencyISO: false,
            onChanged: (Country country) {
              _selected.value = country;
            },
            selectedCountry: _selected.value,
          );
        },
      ),
    );
  }
}
