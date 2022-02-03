import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_pambo/providers/uploads_provider.dart';
import 'package:provider/provider.dart';

class TopTabView extends StatefulWidget {
  const TopTabView({Key? key}) : super(key: key);

  @override
  State<TopTabView> createState() => _TopTabViewState();
}

class _TopTabViewState extends State<TopTabView> {
  @override
  void initState(){
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<UploadsDataProvider>(context,listen: false).getUploads(context);
    });
    super.initState();

  }

   String getImages(Map<String,dynamic>images){
     return json.decode(images['url'])[0];
   }
   String getTitle(title){
     return title;
   }

  @override
  Widget build(BuildContext context) {
    final uploads = Provider.of<UploadsDataProvider>(context);
           return  SingleChildScrollView(
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
                               itemCount:3,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (context,index){
                                 return GestureDetector(
                                   onTap: (){
                                     print(uploads);
                                     print(uploads.runtimeType);
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
                                             =>const Center(
                                               child:  CircularProgressIndicator(
                                                 strokeWidth: 0.5,
                                                 color: Constants.pamboprimaryColor,
                                               ),
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
                                             const Text("sampletitle",style:  TextStyle(color: Colors.white,fontSize: 12),),
                                            const  Text('Price ranges',style:  TextStyle(color:Constants.pamboprimaryColor,fontSize: 12),),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children:   const [
                                                 Icon(Icons.location_on,color: Colors.blueGrey,size: 15,),
                                                 Text('location',style: TextStyle(color:Colors.blueGrey,fontSize: 12))
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
                       itemCount: 2,
                       itemBuilder: (context,index){
                         return GestureDetector(
                           onTap: (){
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
                                           =>const Center(
                                             child:  CircularProgressIndicator(
                                               strokeWidth: 0.5,
                                               color: Constants.pamboprimaryColor,
                                             ),
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
                                               'title',
                                               maxLines:getTitle('title').length > 30 ? 2 :1,
                                               style: const TextStyle(
                                                   fontSize: 13,
                                                   fontWeight: FontWeight.bold,
                                                   overflow:TextOverflow.ellipsis
                                               )),
                                           Padding(
                                             padding: getTitle('title').length > 30 ? const EdgeInsets.only(top:4.0): const EdgeInsets.only(top:7),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(bottom: 2.0,top: 2.0),
                                                   child: Row(
                                                     children: [
                                                       RatingBar.builder(
                                                         itemSize: 20,
                                                         initialRating: 3.5,
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
                                                       const Text('(3.5)',style:Constants.pambocardrateTextStyle),
                                                     ],
                                                   ),
                                                 ),
                                                  const Padding(
                                                   padding:EdgeInsets.only(bottom: 2.0,top: 4),
                                                   child: Text('price Range',style: TextStyle(color:Constants.pamboprimaryColor,fontWeight: FontWeight.bold,fontSize: 13),),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.only(top:4.0,bottom: 2.0),
                                                   child: Row(
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                     children:  const [
                                                       Icon(Icons.location_on,color:Colors.grey,),
                                                       Flexible(
                                                         child: Text(
                                                           'location',
                                                           overflow: TextOverflow.ellipsis,
                                                           style:TextStyle(fontSize: 13,color: Colors.grey),),
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
           );
  }
}
