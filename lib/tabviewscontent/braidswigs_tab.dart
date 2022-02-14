import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/braidswigs_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';

class BraidswigslistScreen extends StatefulWidget {
  const BraidswigslistScreen({Key? key}) : super(key: key);

  @override
  _BraidswigslistScreenState createState() => _BraidswigslistScreenState();
}

class _BraidswigslistScreenState extends State<BraidswigslistScreen> {
  @override
  void initState() {
    final braidswigs = Provider.of<BraidswigsDataProvider>(
        context, listen: false);
    braidswigs.getBraidsWigs(context);
    super.initState();
  }

  String countBraidswigs(dynamic vals, int index) {
    if (vals.elementAt(index).length > 1) {
      return vals.elementAt(index).length.toString() + ' services';
    } else if (vals.elementAt(index).length == 1) {
      return vals.elementAt(index).length.toString() + ' service';
    } else {
      return 'No services available';
    }
  }

  List<DataModel> braidswigsToModel(List<dynamic> braidswigsToConvert) {
    return braidswigsToConvert.map((braidswigs) => DataModel.fromJson(braidswigs)).toList();
  }


  @override
  Widget build(BuildContext context) {
    final braidswigs = Provider.of<BraidswigsDataProvider>(context,listen: false);
    return ListView.builder(
        itemCount: braidswigs.braidswigsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: (index % 2 == 0) ? Colors.white : Colors.grey[100],
              child: ListTile(
                title: Text(braidswigs.braidswigsData.keys.elementAt(index)),
                subtitle: Text(
                  countBraidswigs(braidswigs.braidswigsData.values, index),
                  style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  braidswigs.braidswigsData.values
                      .elementAt(index)
                      .length > 0 ?
                  await Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CategoricalViews(
                                  data: braidswigsToModel(braidswigs
                                      .braidswigsData.values.elementAt(
                                      index)))))
                      : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                          backgroundColor: Constants.pamboprimaryColor,
                          content: Text('No services')));
                },
              )
          );
        }
    );
  }
}

