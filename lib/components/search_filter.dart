import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class PricerangeFilter extends StatefulWidget {
  const PricerangeFilter({Key? key}) : super(key: key);

  @override
  _PricerangeFilterState createState() => _PricerangeFilterState();
}

class _PricerangeFilterState extends State<PricerangeFilter> {
  var dropdownValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
             child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                     border: Border.all(color: Constants.pamboprimaryColor, width: 0.4)),
                 padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                 child: DropdownButtonHideUnderline(
                   child: ButtonTheme(
                     alignedDropdown: true,
                     child: DropdownButton(
                       hint: const Text('Filter by price range',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
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
                       items: <String>['0 - 200', '201 - 500', '501 - 1200', '1201 - 10000','Above 10000'].map((option) {
                         return DropdownMenuItem(
                           value: option,
                           child: Text(option),
                         );
                       }).toList(),
                     ),
                   ),
                 )
             ),
           ),
          const Padding(
            padding: EdgeInsets.only(top:4.0,bottom: 4.0),
            child:  TextField(
                cursorColor: Constants.pamboprimaryColor,
                decoration: InputDecoration(
                  hintText: 'Filter by keyword',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w300,fontSize: 13
                    ),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true
                )),
          ),
           const Padding(
            padding: EdgeInsets.only(left:4.0,right: 4.0,top: 8.0),
            child:  TextField(

                cursorColor: Constants.pamboprimaryColor,
                decoration: InputDecoration(
                    hintText: 'Filter by location',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,fontSize: 13
                    ),
                    fillColor: Color(0xfff3f3f4),
                    filled: true
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Constants.pamboprimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Colors.white)
                    )
                ),
              ),
              child: const Text("SEARCH",style: TextStyle(color: Constants.pamboscaffoldColor),),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
            ),
          )
        ],
      ),
    );

  }
}
