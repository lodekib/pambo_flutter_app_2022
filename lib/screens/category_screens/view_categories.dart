import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/helpers/helper_functions.dart';
import 'package:new_pambo/model/data_model.dart';

import '../details_screen.dart';
class CategoricalViews extends StatelessWidget {
 final List<DataModel> data;
 final String subcategory;
 const CategoricalViews({Key? key,required this.data, required this.subcategory}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: Constants.pamboprimaryColor,
        title: Text(subcategory),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
// TODO :Morning Brian remember to change the range from 10 to some arbitrary value like 50,100....
            itemCount: data.isNotEmpty ? data.length:0,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  print(data[index].reviews);
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
                              imageUrl:'https://img.search.brave.com/VNoQqiC3ZvUDh9KJr1UZhq59Ri-ttYAOLNURRoPUn5E/rs:fit:844:225:1/g:ce/aHR0cHM6Ly90c2Ux/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC4x/MmNHWXdULVJpTmpG/eGY0ZjdBbXpRSGFF/SyZwaWQ9QXBp',
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
                                    data[index].title,
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
                                              initialRating: data[index].reviews.isNotEmpty ? Helper().reviews(data[index].reviews):0.0,
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
                                            Text(data[index].reviews.isNotEmpty ? Helper().reviews(data[index].reviews).toString():'(0.0)',style:Constants.pambocardrateTextStyle),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:const EdgeInsets.only(bottom: 2.0,top: 4),
                                        child: Text('KSH '+data[index].price_from+' - KSH '+data[index].price_to,style: const TextStyle(color:Constants.pamboprimaryColor,fontWeight: FontWeight.bold,fontSize: 13),),
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
                                                data[index].location,
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
                                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailsPage(data: data[index])));
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
            }),
      )
    );

  }
}
