import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_pambo/components/drawer.dart';
import 'package:new_pambo/components/search_filter.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/screens/checkAuth.dart';
import 'package:new_pambo/screens/login_screen.dart';
import 'package:new_pambo/tab_components/tabs.dart';
import 'package:new_pambo/tabviewscontent/braidswigs_tab.dart';
import 'package:new_pambo/tabviewscontent/fragrance_tab.dart';
import 'package:new_pambo/tabviewscontent/hair_dressing_tab.dart';
import 'package:new_pambo/tabviewscontent/jewellery_tab.dart';
import 'package:new_pambo/tabviewscontent/makeup_tab.dart';
import 'package:new_pambo/tabviewscontent/massage_tab.dart';
import 'package:new_pambo/tabviewscontent/skin_care_tab.dart';
import 'package:new_pambo/tabviewscontent/top_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin{
  int currentIndex=0;
  String greet='';


  @override
  void initState(){

    super.initState();
  }


  List  <Widget>pages = <Widget>[
    const CheckAuthentication(),
    const LoginScreen()
  ];



  void onItemTap(int index){
   setState(() {
     currentIndex = index;
     Navigator.push(context, MaterialPageRoute(builder: (context)=>pages[index]));

   });
  }

  Future<String> checkAuthenticated()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if(localStorage.get('user') != null){
      var user = jsonDecode(localStorage.getString('user')!)['last_name'];
       return 'Welcome, '+user;
    }else{
      return 'Explore more services?';
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: checkAuthenticated(),
        builder: (context,snapshot){
           return DefaultTabController(
             length: 8,
             child: Scaffold(
               backgroundColor: Colors.white,
               drawer:  const MyDrawer(),
               appBar: PreferredSize(
                 preferredSize: const Size.fromHeight(120),
                 child: AppBar(
                   flexibleSpace:Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top:48.0),
                           child: Padding(
                             padding: const EdgeInsets.only(left:8.0),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children:   [
                                   Text(snapshot.data.toString(),style:Constants.pambosearchtextStyle),
                                 ElevatedButton(
                                     onPressed: ()
                                     {
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
                                                 const PricerangeFilter()
                                               ],
                                               ),
                                             );
                                           });
                                     },
                                     child:const Text(
                                       'Search for Service',
                                     ),
                                     style: ButtonStyle(
                                       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                       backgroundColor: MaterialStateProperty.all<Color>(Constants.pamboprimaryColor),
                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                           RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(15.0),
                                               side: const BorderSide(color: Colors.white)
                                           )
                                       ),
                                     )
                                 )
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   elevation: 0.0,
                   backgroundColor: Constants.pamboprimaryColor,
                   bottom:TabBar(
                       unselectedLabelColor:Colors.white.withOpacity(.5),
                       indicatorSize: TabBarIndicatorSize.label,
                       isScrollable: true,
                       tabs: Constants.tabList.map((TabChoice tabChoice) {
                         return Row(
                           children: [
                             Image.asset(tabChoice.image),
                             const SizedBox(width:5),
                             Text(tabChoice.category)
                           ],
                         );
                       }).toList()
                   ),
                 ),
               ),
               bottomNavigationBar: BottomNavigationBar(
                   onTap: onItemTap,
                   currentIndex:currentIndex,
                   selectedItemColor: Constants.pamboprimaryColor,
                   unselectedItemColor:Constants.pamboprimaryColor,
                   showUnselectedLabels: true,
                   backgroundColor: Constants.pamboscaffoldColor,
                   elevation: 0,
                   items: const [
                     BottomNavigationBarItem(
                         icon: Icon(Icons.post_add,size: 30,),
                         label:'Upload Service'),
                     BottomNavigationBarItem(
                         icon:Icon(Icons.account_circle_outlined,size: 30,),
                         label:'Account'
                     )
                   ]
               ),
               body:   TabBarView(
                 children: [
                   TopTabView(),
                   FragrancelistScreen(),
                   JewellerylistScreen(),
                   MakeuplistScreen(),
                   SkincarelistScreen(),
                   MassagelistScreen(),
                   HairdressinglistScreen(),
                   BraidswigslistScreen()
                 ],

               ),
             ),
           );
        }
    ) ;

  }

}


