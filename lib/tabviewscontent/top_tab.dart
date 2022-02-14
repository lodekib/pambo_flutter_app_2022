import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_pambo/helpers/helper_functions.dart';
import 'package:new_pambo/providers/uploads_provider.dart';
import 'package:new_pambo/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TopTabView extends StatefulWidget {
  const TopTabView({Key? key}) : super(key: key);

  @override
  State<TopTabView> createState() => _TopTabViewState();
}

class _TopTabViewState extends State<TopTabView> {

  @override
  void initState(){
    super.initState();
    final data = Provider.of<UploadsDataProvider>(context,listen: false);
      data.fetchData(context);
  }

   String getImages(Map<String,dynamic>images){
     return json.decode(images['url'])[0];
   }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UploadsDataProvider>(context);
           return  data.dataModel.isNotEmpty ? SingleChildScrollView(
             child: Column(
               children:   [
                 //  TOP SERVICES
                 Padding(
                   padding:  const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Padding(
                         padding: EdgeInsets.only(bottom:10.0),
                         child: Text('Trending Services',
                           style: TextStyle(
                               color: Color(0xFFDB228E),
                               fontSize: 16,
                               fontWeight:FontWeight.bold
                           ),),
                       ),
                       SizedBox(
                           height: MediaQuery.of(context).size.height*.3,
                           width: double.maxFinite,
                           child:ListView.builder(
                               itemCount:data.dataModel.isNotEmpty ? data.dataModel.take(2).length :0,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (context,index){
                                 return GestureDetector(
                                   onTap: (){
                                     print(data.dataModel.runtimeType);
                                   },
                                   child: Stack(
                                     children: [
                                       Padding(
                                         padding:  const EdgeInsets.only(right:8.0),
                                         child: Container(
                                           width: MediaQuery.of(context).size.width*.5,
                                           height: MediaQuery.of(context).size.height*.3,
                                           decoration: BoxDecoration(
                                             borderRadius:BorderRadius.circular(10),
                                             color: Colors.white
                                           ),
                                           child:CachedNetworkImage(
                                             fit: BoxFit.cover,
                                             imageUrl:'',
                                             progressIndicatorBuilder: (context,url,downloadProgress)
                                             => const Center(
                                               child: SpinKitCircle(
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
                                       Padding(
                                         padding:  const EdgeInsets.only(bottom:4.0,left: 4.0),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children:  [
                                              Text(data.dataModel[index].title ,style:  const TextStyle(color: Colors.white,fontSize: 12),),
                                              Text('KSH '+data.dataModel[index].price_from+' - KSH '+data.dataModel[index].price_to,style: const TextStyle(color:Constants.pamboprimaryColor,fontSize: 12),),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children:    [
                                                 const Icon(Icons.location_on,color: Colors.blueGrey,size: 15,),
                                                 Text(data.dataModel[index].location,style: const TextStyle(color:Colors.blueGrey,fontSize: 12))
                                               ],
                                             ),

                                           ],
                                         ),
                                       )
                                     ],
                                   ),
                                 );
                               })
                       )
                     ],
                   ),
                 ),
                 const Padding(
                   padding: EdgeInsets.only(left:8.0,right:8.0),
                   child: Divider(color:Color(0xFFDB228E),),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ListView.builder(
                       shrinkWrap: true,
                       physics: const ClampingScrollPhysics(),
                       scrollDirection: Axis.vertical,
// TODO :Morning Brian remember to change the range from 10 to some arbitrary value like 50,100....
                       itemCount: data.dataModel.isNotEmpty ? data.dataModel.sublist(1).length :0,
                       itemBuilder: (context,index){
                         return GestureDetector(
                           onTap: (){
                             print(data.dataModel[index].reviews);
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
                                               data.dataModel[index].title,
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
                                                         initialRating: data.dataModel[index].reviews.isNotEmpty ? Helper().reviews(data.dataModel[index].reviews):0.0,
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
                                                        Text(data.dataModel[index].reviews.isNotEmpty ? Helper().reviews(data.dataModel[index].reviews).toString():'(0.0)',style:Constants.pambocardrateTextStyle),
                                                     ],
                                                   ),
                                                 ),
                                                   Padding(
                                                   padding:const EdgeInsets.only(bottom: 2.0,top: 4),
                                                   child: Text('KSH '+data.dataModel[index].price_from+' - KSH '+data.dataModel[index].price_to,style: const TextStyle(color:Constants.pamboprimaryColor,fontWeight: FontWeight.bold,fontSize: 13),),
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
                                                           data.dataModel[index].location,
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
                                                             Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailsPage(data: data.dataModel[index])));
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
                 //   TOP SERVICES
               ],
             ),
           ) : const Center(
             child: SpinKitSpinningLines(
               color: Constants.pamboprimaryColor,
               size: 50.0,
             )
           );
  }

}
