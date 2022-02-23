import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/network_utils/api.dart';
import 'package:new_pambo/screens/search_screen.dart';

class PricerangeFilter extends StatefulWidget {
  const PricerangeFilter({Key? key}) : super(key: key);

  @override
  _PricerangeFilterState createState() => _PricerangeFilterState();
}

class _PricerangeFilterState extends State<PricerangeFilter> {
  // ignore: prefer_typing_uninitialized_variables
  var dropdownValue;
  bool isSearching = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController keywordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                        color: Constants.pamboprimaryColor, width: 0.4)),
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: const Text(
                        'Filter by price range',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w300),
                      ),
                      isExpanded: true,
                      isDense: true,
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Constants.pamboprimaryColor,
                      ),
                      iconSize: 30,
                      underline: Container(
                        height: 1,
                        color: Colors.transparent,
                      ),
                      onChanged: (val) {
                        setState(() {
                          dropdownValue = val as String;
                        });
                      },
                      items: <String>[
                        '0 - 200',
                        '201 - 500',
                        '501 - 1200',
                        '1201 - 10000',
                        '10000-50000'
                      ].map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: TextField(
                controller: keywordController,
                cursorColor: Constants.pamboprimaryColor,
                decoration: const InputDecoration(
                    hintText: 'Filter by keyword',
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
            child: TextField(
                controller: locationController,
                cursorColor: Constants.pamboprimaryColor,
                decoration: const InputDecoration(
                    hintText: 'Filter by location',
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Constants.pamboprimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Colors.white))),
              ),
              child: !isSearching
                  ? const Text(
                      "SEARCH",
                      style: TextStyle(color: Constants.pamboscaffoldColor),
                    )
                  : const SpinKitThreeBounce(
                      color: Constants.pamboprimaryColor,
                      size: 15,
                    ),
              onPressed: () async {
                setState(() {
                  isSearching = true;
                });
                bool isPriceRange = dropdownValue != null;
                bool isKeyword = keywordController.text.isNotEmpty;
                bool isLocation = locationController.text.isNotEmpty;
                if (!isPriceRange && !isKeyword && !isLocation) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Constants.pamboprimaryColor,
                      behavior: SnackBarBehavior.floating,
                      content: Text('Provide atleast one search query')));
                } else {
                  print(isPriceRange);
                  print(isKeyword);
                  print(isLocation);
                  var data = <String, String>{
                    'search_price_range': isPriceRange ? dropdownValue : '',
                    'search_keyword': isKeyword ? keywordController.text : '',
                    'search_location': isLocation ? locationController.text : ''
                  };

                  var response = await Network()
                      .searchHelper(data, isPriceRange, isKeyword, isLocation);
                  var resp = json.decode(response.body);
                  print(resp['state']);
                  if (resp['state']) {
                    List<dynamic> data = resp['data'];
                    if (data.isNotEmpty) {
                      List<DataModel> finalData =
                          data.map((e) => DataModel.fromJson(e)).toList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  SearchScreen(searchData: finalData)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Constants.pamboprimaryColor,
                          behavior: SnackBarBehavior.floating,
                          content: Text('No search results found')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Constants.pamboprimaryColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text('Unable to complete the search')));
                  }
                }
                setState(() {
                  isSearching = false;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
