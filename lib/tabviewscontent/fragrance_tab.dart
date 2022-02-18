import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/fragrance_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';


class FragrancelistScreen extends StatelessWidget {

  String countFrags(dynamic vals, int index) {
    if (vals.elementAt(index).length > 1) {
      return vals.elementAt(index).length.toString() + ' services';
    } else if (vals.elementAt(index).length == 1) {
      return vals.elementAt(index).length.toString() + ' service';
    } else {
      return 'No services available';
    }
  }

  List<DataModel> fragsToModel(List<dynamic> fragsToConvert) {
    return fragsToConvert.map((frag) => DataModel.fromJson(frag)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FragranceDataProvider().fetchFrags(context),
          builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          case ConnectionState.none:
          return const Text(
          'Fetch fragrance data',
          textAlign: TextAlign.center,
);
          case ConnectionState.active:
          return const Text('connection active');
          case ConnectionState.waiting:
          return  const SpinKitThreeBounce(
             color: Constants.pamboprimaryColor,
            size: 30,
          );
          case ConnectionState.done:
          if (snapshot.hasError) {
          return const Icon(Icons.hide_source,size: 50,color: Constants.pamboprimaryColor,);
} else {
  Map<String,dynamic> frags = snapshot.data as Map<String,dynamic> ;
  return ListView.builder(
          itemCount: frags.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: (index % 2 == 0) ? Colors.white : Colors.grey[100],
                child: ListTile(
                  title: Text(frags.keys.elementAt(index)),
                  subtitle: Text(
                    countFrags(frags.values, index),
                    style: const TextStyle(fontSize: 13),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    frags.values.elementAt(index).length > 0
                        ? await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategoricalViews(
                                    subcategory:
                                        frags.keys.elementAt(index),
                                    data: fragsToModel(frags.values
                                        .elementAt(index)))))
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                                backgroundColor: Constants.pamboprimaryColor,
                                content: Text('No services')));
                  },
                ));
          });
}
}
},
);
    // final frags = Provider.of<FragranceDataProvider>(context, listen: false);
    // return ListView.builder(
    //     itemCount: frags.fragranceData.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Card(
    //           color: (index % 2 == 0) ? Colors.white : Colors.grey[100],
    //           child: ListTile(
    //             title: Text(frags.fragranceData.keys.elementAt(index)),
    //             subtitle: Text(
    //               countFrags(frags.fragranceData.values, index),
    //               style: const TextStyle(fontSize: 13),
    //             ),
    //             trailing: const Icon(Icons.chevron_right),
    //             onTap: () async {
    //               frags.fragranceData.values.elementAt(index).length > 0
    //                   ? await Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (_) => CategoricalViews(
    //                               subcategory:
    //                                   frags.fragranceData.keys.elementAt(index),
    //                               data: fragsToModel(frags.fragranceData.values
    //                                   .elementAt(index)))))
    //                   : ScaffoldMessenger.of(context).showSnackBar(
    //                       const SnackBar(
    //                           behavior: SnackBarBehavior.floating,
    //                           duration: Duration(seconds: 1),
    //                           backgroundColor: Constants.pamboprimaryColor,
    //                           content: Text('No services')));
    //             },
    //           ));
    //     });
  }
}

//     return FutureBuilder(
// future: Provider.of<FragranceDataProvider>(context, listen: false).fetchFragrances(context),
// builder: (context, snapshot) {
// switch (snapshot.connectionState) {
// case ConnectionState.none:
// return Text(
// 'Fetch opportunity data',
// textAlign: TextAlign.center,
// );
// case ConnectionState.active:
// return Text('');
// case ConnectionState.waiting:
// return Text("Fetching Fragrances...");
// case ConnectionState.done:
// if (snapshot.hasError) {
// return Text(
//  "Error retrieving chucky categories.",
// );
// } else {
// return Text('');
// }
// }
// },
// );
