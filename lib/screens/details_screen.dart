import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pambo/components/rate_pop_up.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/cubit/app_cubit_states.dart';
import 'package:new_pambo/cubit/app_cubits.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  List getImages(Map<String,dynamic>images){
    return json.decode(images['url']);
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits,CubitStates>(
      builder: (context,state){
        DetailState detail = state as DetailState;
        return Scaffold(
            body:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 1500,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child:CarouselSlider.builder(
                              itemCount: getImages(detail.upload.image).length,
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                                aspectRatio: 1.0,
                                initialPage: 0,
                              ),
                              itemBuilder: (context,itemIndex,pageViewIndex)=>
                                  Container(
                                    width: double.maxFinite,
                                    height: MediaQuery.of(context).size.height*.45,
                                   child:CachedNetworkImage(
                                     fit: BoxFit.cover,
                                     filterQuality: FilterQuality.medium,
                                     imageUrl:'https://51a6-197-248-49-247.ngrok.io/storage/uploads/'+getImages(detail.upload.image)[itemIndex],
                                     progressIndicatorBuilder: (context,url,downloadProgress)
                                     =>const Center(
                                       child:  CircularProgressIndicator(
                                         strokeWidth: 0.5,
                                         color: Constants.pamboprimaryColor,
                                       ),
                                     ),
                                     errorWidget: (context,url,error)=>Center(child: Column(
                                       children: const [
                                         Icon(Icons.error,size:15,color: Constants.pamboprimaryColor,),
                                         Text('Check your Internet Connection!',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 13),)
                                       ],
                                     )),
                                   ),
                                  )
                          ),
                        ),
                        Positioned(
                            left: 20,
                            top: 40,
                            child:IconButton(
                              onPressed: () {
                                BlocProvider.of<AppCubits>(context).goHome();
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Constants.pamboprimaryColor,
                            )
                        ),
                        Positioned(
                            top: MediaQuery.of(context).size.height*.43,
                            child: Container(
                              height: MediaQuery.of(context).size.height*2,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  color: Constants.pamboscaffoldColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: ElevatedButton(
                                              onPressed: () async{
                                                 await canLaunch('tel://'+detail.upload.phone) ? launch('tel://'+detail.upload.phone) : ScaffoldMessenger.of(context).showSnackBar(
                                                   const SnackBar(content:Text('Unable to launch phone Dial'))
                                                 );
                                              },
                                              child: const Icon(Icons.phone,color: Constants.pamboprimaryColor,),
                                              style: ButtonStyle(
                                                overlayColor: MaterialStateProperty.all(Constants.pambootherprimaryColor),
                                                elevation: MaterialStateProperty.all(2),
                                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:8.0,right: 2),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                var phone = '254'+detail.upload.phone.substring(1);
                                                await canLaunch('whatsapp://send?phone=$phone') ?
                                                launch('whatsapp://send?phone=$phone') : ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Unable to launch Whatsapp Messenger'),));
                                              },
                                              child:Image.asset('assets/images/icons8-whatsapp-24.png'),
                                              style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(2),
                                                backgroundColor: MaterialStateProperty.all(Constants.pamboprimaryColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Row(
                                        children:  [
                                          Text(
                                            detail.upload.title,
                                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            children: [
                                              Wrap(
                                                  children:List.generate(5, (index){
                                                    return Icon(Icons.star,color: Constants.pambostarsColor,size: 20,);
                                                  })
                                              ),
                                              const SizedBox(width: 10,),
                                              const Text('(5.0)',style:Constants.pambocardrateTextStyle),
                                            ],
                                          ),
                                        ),
                                         Text('KSH '+detail.upload.price_from+' - KSH '+detail.upload.price_to,
                                          style:const TextStyle(color:Colors.green,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(
                                      children:  [
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            children:   [
                                              const Icon(Icons.location_on,color:Colors.grey,),
                                             const  SizedBox(width: 5,),
                                              Text(detail.upload.sub_county+' , '+detail.upload.location,style:const TextStyle(fontSize: 13,color: Colors.grey),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const  Divider(),
                                    Column(
                                      children: [
                                        Row(
                                          children: const <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 30.0),
                                                child: Text(
                                                  "Service Description",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Constants.pamboprimaryColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                         ReadMoreText(
                                          detail.upload.description,
                                          style:const TextStyle(color:Colors.black,fontWeight: FontWeight.w300,fontSize: 13),
                                          trimLines: 7,
                                          trimLength: 5,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: '...See More',
                                          moreStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constants.pamboprimaryColor,
                                              fontSize:14
                                          ),
                                          lessStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constants.pamboprimaryColor,
                                              fontSize:14
                                          ),
                                          trimExpandedText: ' See Less ',
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:  [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text('Rate this service',style:Constants.pamborateStyle),
                                              Text('Tell others what you think',style:Constants.pambocardrateTextStyle)
                                            ],
                                          ),
                                          OutlinedButton(
                                              onPressed: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Stack(
                                                          clipBehavior: Clip.none, children: <Widget>[
                                                          Positioned(
                                                            right: -40.0,
                                                            top: -40.0,
                                                            child: InkResponse(
                                                              onTap: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: const CircleAvatar(
                                                                child: Icon(Icons.close),
                                                                backgroundColor: Constants.pamboprimaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                          RateService()
                                                        ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: const Text('Write a Review',style: TextStyle(color:Constants.pamboprimaryColor),)
                                          )

                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Row(
                                      children:  [
                                        Expanded(
                                          child: OutlinedButton(
                                              onPressed: (){},
                                              style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all(Colors.green)
                                              ),
                                              child: const Text('Report a legal  issue')
                                          ),
                                        ),

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Text('Reviews',style: TextStyle(color:Colors.green)),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 25,
                                          itemBuilder: (context,index){
                                            return   Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircularProfileAvatar('',
                                                          radius: 20,
                                                          backgroundColor: Colors.transparent,
                                                          borderWidth: 0,
                                                          initialsText:const Text(
                                                            "B",
                                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                                          ),
                                                          borderColor: Colors.brown,
                                                          foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                                                          imageFit : BoxFit.cover,
                                                          onTap: () {},
                                                        ),
                                                        const  SizedBox(width: 10,),
                                                        const Text('Brian ')
                                                      ],
                                                    ),
                                                    Wrap(
                                                        children:List.generate(5, (index){
                                                          return const Icon(Icons.star,color: Colors.green,size: 10,);
                                                        })
                                                    ),


                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: ReadMoreText(
                                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum neque'
                                                        ' efficitur blandit urna. '
                                                        'Duis congue pellentesque sapien in tempor. Pellentesque laoreet arcu ac sem posuere posuere.',
                                                    style:TextStyle(color:Colors.grey,fontSize: 13),
                                                    trimLines: 4,
                                                    trimLength: 5,
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText: '...>>>',
                                                    moreStyle: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Constants.pamboprimaryColor,
                                                        fontSize:14
                                                    ),
                                                    lessStyle: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Constants.pamboprimaryColor,
                                                        fontSize:14
                                                    ),
                                                    trimExpandedText: ' <<<',
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: const[
                                                    Text('18/01/22',style: TextStyle(fontWeight:FontWeight.w100,fontSize: 12),)
                                                  ],
                                                )
                                              ],

                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}