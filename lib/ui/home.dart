import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_converter/model/currency_model.dart';
import 'package:currency_converter/service/api_service.dart';
import 'package:currency_converter/ui/components/all_currency_listitem.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService = ApiService();
  String _selectedCurrency = "USD";

  Widget _dropDownItem(Country country) => Container(
        child: Row(
          children: [
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8,
            ),
            Text('${country.currencyName}')
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CountryPickerDropdown(
            initialValue: 'us',
            itemBuilder: _dropDownItem,
            onValuePicked: (Country? country) {
              setState(() {
                _selectedCurrency = country?.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "All Currency",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CurrencyModel> currencyModelList = snapshot.data ?? [];
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return AllCurrencylistItem(
                      currencyModel: currencyModelList[index],
                    );
                  },
                  itemCount: currencyModelList.length,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error occurred",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: apiService.getLatest(_selectedCurrency),
        ),
      ],
    );
  }
}