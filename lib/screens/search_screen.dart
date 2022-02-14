import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/helpers/helper_functions.dart';
import 'package:new_pambo/model/data_model.dart';

import 'details_screen.dart';

class SearchScreen extends StatelessWidget {
  List<DataModel> searchData ;
   SearchScreen({required this.searchData ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body:CustomScrollView(
       slivers: [
         SliverAppBar(
           backgroundColor: Constants.pamboprimaryColor,
           pinned: true,
           floating: true,
           expandedHeight: 100,
           flexibleSpace: FlexibleSpaceBar(
             centerTitle: true,
             title: const Padding(
               padding: EdgeInsets.only(top:8.0),
               child: Text('Search Results',style: TextStyle(fontSize: 10),),
             ),
             background: Image.asset('assets/images/icons8-marker-p-50.png')
           ),
         ),
         const SliverToBoxAdapter(
           child: SizedBox(
             height: 20,
             child: Center(
               child: Text(''),
             ),
           ),
         ),
         SliverList(
           delegate: SliverChildBuilderDelegate(
                 (BuildContext context, int index) {
                   return GestureDetector(
                onTap: (){
                  print(searchData[index].reviews);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*.28,
                  child: Card(
                    elevation: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex:1,
                          child: Container(
                            height: MediaQuery.of(context).size.height*.28,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:'',
                              progressIndicatorBuilder: (context,url,downloadProgress)
                              => const Center(
                                  child:  SpinKitCircle(
                                    size: 40,
                                    color: Constants.pamboprimaryColor,
                                  )
                              ),
                              errorWidget: (context,url,error)=>Center(child: Column(
                                children: const [
                                  Icon(Icons.error,size:20,color: Constants.pamboprimaryColor,),
                                  Text('Connection Timeout!',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 13),)
                                ],
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                    searchData[index].title,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        overflow:TextOverflow.ellipsis
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top:7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 2.0,top: 2.0),
                                        child: Row(
                                          children: [
                                            RatingBar.builder(
                                              itemSize: 20,
                                              initialRating: searchData[index].reviews.isNotEmpty ? Helper().reviews(searchData[index].reviews):0.0,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemBuilder: (context, _) => const Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                              ), onRatingUpdate: (double value) {  },
                                            ),
                                            const SizedBox(width: 5,),
                                            Text(searchData[index].reviews.isNotEmpty ? Helper().reviews(searchData[index].reviews).toString():'(0.0)',style:Constants.pambocardrateTextStyle),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:const EdgeInsets.only(bottom: 2.0,top: 4),
                                        child: Text('KSH '+searchData[index].price_from+' - KSH '+searchData[index].price_to,style: const TextStyle(color:Constants.pamboprimaryColor,fontWeight: FontWeight.bold,fontSize: 13),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:4.0,bottom: 2.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:   [
                                            const Icon(Icons.location_on,color:Colors.grey,),
                                            Flexible(
                                              child: Text(
                                                searchData[index].location,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 13,color: Colors.grey),),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:4.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailsPage(data: searchData[index])));
                                                },
                                                child: const Text('View Service',style: TextStyle(color:Constants.pamboprimaryColor),)
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
             },
             childCount: searchData.length,
           ),
         ),

       ],
     )
    );
  }



}