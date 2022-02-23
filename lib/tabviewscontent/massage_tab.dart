import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/massage_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';

class MassagelistScreen extends StatelessWidget {
  const MassagelistScreen({Key? key}) : super(key: key);

  String countMassages(dynamic vals, int index) {
    if (vals.elementAt(index).length > 1) {
      return vals.elementAt(index).length.toString() + ' services';
    } else if (vals.elementAt(index).length == 1) {
      return vals.elementAt(index).length.toString() + ' service';
    } else {
      return 'No services available';
    }
  }

  List<DataModel> massagesToModel(List<dynamic> massagesToConvert) {
    return massagesToConvert.map((frag) => DataModel.fromJson(frag)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MassageDataProvider().getMassages(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return const Text('Connection is active');
            case ConnectionState.none:
              return const Text('No connection');
            case ConnectionState.waiting:
              return const SpinKitThreeBounce(
                size: 30,
                color: Constants.pamboprimaryColor,
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Icon(
                  Icons.hide_source,
                  size: 50,
                  color: Constants.pamboprimaryColor,
                );
              } else {
                Map<String, dynamic> massages =
                    snapshot.data as Map<String, dynamic>;
                return ListView.builder(
                    itemCount: massages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: (index % 2 == 0)
                              ? Colors.white
                              : Colors.grey[100],
                          child: ListTile(
                            title: Text(massages.keys.elementAt(index)),
                            subtitle: Text(
                              countMassages(massages.values, index),
                              style: const TextStyle(fontSize: 13),
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () async {
                              massages.values.elementAt(index).length > 0
                                  ? await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CategoricalViews(
                                              subcategory: massages.keys
                                                  .elementAt(index),
                                              data: massagesToModel(massages
                                                  .values
                                                  .elementAt(index)))))
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 1),
                                          backgroundColor:
                                              Constants.pamboprimaryColor,
                                          content: Text('No services')));
                            },
                          ));
                    });
              }
          }
        });
    //
  }
}
