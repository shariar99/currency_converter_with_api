import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _dropDownItem(Country country) => Container(
    child: Row(
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8,),
        Text('${country.currencyName}')
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 8,
        ),
        Text(
          "Base Currency",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        CountryPickerDropdown(
          initialValue: CountryPickerUtils.getCountryByIsoCode('US'), // Use 'US' instead of 'us'
          itemBuilder: _dropDownItem,
          onValuePicked: (Country? country) {},
        ),
      ],
    );
  }
}
