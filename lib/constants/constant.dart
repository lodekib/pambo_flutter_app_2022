import 'package:flutter/material.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:new_pambo/tab_components/tabs.dart';
import 'package:new_pambo/tabviewscontent/fragrance_tab.dart';

class Constants{
  static const Color pamboprimaryColor =  Color(0xFFDB228E);
  static  Color pambootherprimaryColor =  const Color(0xFFDB228E).withOpacity(.5);
  static const TextStyle pamborateStyle =  TextStyle(
      color:Colors.green,fontWeight: FontWeight.bold
  );

  static String baseUrl = 'https://fe28-197-248-49-247.ngrok.io/api/v1';

  static const Color  pamboscaffoldColor =  Color(0xFFFFFFFF);
  static Color pambounselectedtabColor = Colors.grey;
  static Color pambostarsColor =  Colors.orange;
  static const TextStyle pambocardTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold
  );
  static const TextStyle pambocardrateTextStyle = TextStyle(
    color:Colors.grey,
      fontSize: 13,
  );
  static const TextStyle pambosearchtextStyle =  TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold
  );


  static List<TabChoice> tabList = <TabChoice>[
    TabChoice(category: 'Top', image: 'assets/images/icons8-fire-35.png', goTo: const HomeScreen()),
    TabChoice(category: 'Fragrance', image: 'assets/images/icons8-fragrance-35.png', goTo: const FragrancelistScreen()),
    TabChoice(category: 'Jewellery', image: 'assets/images/icons8-earrings-35.png', goTo: const HomeScreen()),
    TabChoice(category: 'Makeup', image: 'assets/images/icons8-makeup-35.png', goTo: const HomeScreen()),
    TabChoice(category: 'Skin Care', image: 'assets/images/icons8-cream-35.png', goTo: const HomeScreen()),
    TabChoice(category: 'Massage', image: 'assets/images/icons8-massage-35.png', goTo: const HomeScreen()),
    TabChoice(category: 'Hair Dressing', image: 'assets/images/icons8-man-combing-hair-35.png', goTo: const HomeScreen()),
    TabChoice(category: 'Braids & Wigs', image: 'assets/images/icons8-hair-curler-35.png', goTo: const HomeScreen())
  ];


 static   List<String> categories =  ['Fragrance','Hair Dressing','Make Up','Braids & Wigs','Skin Care','Massage','Jewellery'];



 List <String> counties =["Nairobi","Machakos","Lamu","Kitui","Taita Taveta","Mombasa","Kilifi","Kiambu","Samburu","Bungoma","Vihiga",
    "Kakamega","Kisumu","Migori","Homa Bay","Muranga","Nyandarua","Nakuru","Kericho","Nandi","Turkana","West Pokot","Marsabit",
    "Kirinyaga","Narok","Meru","Tharaka Nithi","Kajiado","Uasin Gishu","Tana River","Mandera","Trans Nzoia","Bomet","Embu","Makueni",
    "Kisii","Nyamira","Isiolo","Garissa","Busia","Elgeyo Marakwet","Kwale","Laikipia","Wajir"
  ];


   static List<Map<String, String>> fragrancesubcategory=[
    {
      "subcategory":"Body Spray",
      "ads":"0 ads",
    },
    {
      "subcategory":"Deodorants",
      "ads":"0 ads",
    },
    {
      "subcategory":"Perfumes",
      "ads":"0 ads",
    },
    {
      "subcategory":"Air Fresheners",
      "ads":"0 ads",
    },
    {
      "subcategory":"Citrus",
      "ads":"0 ads",
    },
    {
      "subcategory":"Fruity",
      "ads":"0 ads",
    },
    {
      "subcategory":"Floral",
      "ads":"0 ads",
    },
    {
      "subcategory":"Woody",
      "ads":"0 ads",
    },
  ];

  static List<Map<String, dynamic>> jewellerylist=[
    {
      "subcategory":"Earings",
      "ads":"0 ads",
    },
    {
      "subcategory":"Bracelets",
      "ads":"0 ads",
    },
    {
      "subcategory":"Necklace",
      "ads":"0 ads",
    },
    {
      "subcategory":"Bangles",
      "ads":"0 ads",
    },
    {
      "subcategory":"Belly Chains",
      "ads":"0 ads",
    },
    {
      "subcategory":"Body Piercing",
      "ads":"0 ads",
    },
    {
      "subcategory":"Tattoos and Body art",
      "ads":"0 ads",
    },
    {
      "subcategory":"Jewellery Engraving",
      "ads":"0 ads",
    },
  ];

  static  List<Map<String, String>> makeupList=[
    {
      "subcategory":"Foundation",
      "ads" :"0 ads",
    },
    {
      "subcategory":"Highlights",
      "ads" :"0 ads",
    },
    {
      "subcategory":"Lipgloss",
      "ads":"0 ads",
    },
    {
      "subcategory":"Nail Polish",
      "ads" :"0 ads",
    },
    {
      "subcategory":"Rouge and Blusher",
      "ads":"0 ads",
    },
    {
      "subcategory":"Lip Balm,Primers and Sticks",
      "ads":"0 ads",
    },
    {
      "subcategory":"Makeup Removing",
      "ads":"0 ads",
    },
    {
      "subcategory":"Concealer",
      "ads" :"0 ads",
    },
    {
      "subcategory":"Contour Powders and Creams",
      "ads":"0 ads",
    },
    {
      "subcategory":"Eyelash glueing",
      "ads" :"0 ads",
    },
    {
      "subcategory":"Eyebrow pencils ",
      "ads":"0 ads",
    },

  ];

  static List<Map<String, String>> skincareList=[
    {
      "subcategory":"Age spots and Acne Scars Removal",
      "ads":"0 ads",
    },
    {
      "subcategory":"Chemical Peeling",
      "ads":"0 ads",
    },
    {
      "subcategory":"Laser Resurfacing",
      "ads":"0 ads",
    },
    {
      "subcategory":"Laser Skin Rejuvenation",
      "ads":"0 ads",
    },
    {
      "subcategory":"Acne Blue Light Therapy",
      "ads":"0 ads",
    },
    {
      "subcategory":"Thermage",
      "ads":"0 ads",
    },

  ];

  static List<Map<String, String>> massagelist=[
    {
      "subcategory":"Hot Stone Massage",
      "ads":"0 ads",
    },
    {
      "subcategory":"Sports Massage",
      "ads":"0 ads",
    },
    {
      "subcategory":"Swedish Massage",
      "ads":"0 ads",
    },
    {
      "subcategory":"Aromatherapy",
      "ads":"0 ads",
    },
    {
      "subcategory":"Deep tissue ",
      "ads":"0 ads",
    },
    {
      "subcategory":"Reflexology",
      "ads":"0 ads",
    },
    {
      "subcategory":"Prenatal",
      "ads":"0 ads",
    },
  ];

  static  List<Map<String, String>> hairdressingsubcategory=[
    {
      "subcategory":"Shaving",
      "ads":"0 ads",
    },
    {
      "subcategory":"Waxing",
      "ads":"0 ads",
    },
    {
      "subcategory":"Dye",
      "ads":"0 ads",
    },
    {
      "subcategory":"Super Cuts",
      "ads":"0 ads",
    },
    {
      "subcategory":"Braids",
      "ads":"0 ads",
    },
    {
      "subcategory":"Dread Locks",
      "ads":"0 ads",
    },
  ];

  static  List<Map<String, String>> braidwigslist=[
    {
      "subcategory":"Hair Conditioners and Shampoos",
      "ads":"0 ads",
    },
    {
      "subcategory":"Hair Serums",
      "ads":"0 ads",
    },
    {
      "subcategory":"Hair Bands",
      "ads":"0 ads",
    },
    {
      "subcategory":"Frontal Wigs",
      "ads":"0 ads",
    },
    {
      "subcategory":"Dread Locks",
      "ads":"0 ads",
    },
    {
      "subcategory":"Wigs Extensions",
      "ads":"0 ads",
    },
    {
      "subcategory":"Artificial Braids",
      "ads":"0 ads",
    },

  ];

  getSubCounty(value){
    List<String> subcounties=[];
    switch(value){
    case 'Mombasa':
      subcounties=['Changamwe','Jomvu','Kisauni','Likoni','Mvita','Nyali'];
      break;
    case 'Kwale':
      subcounties=['Kinago','Lungalunga','Matuga','Msambweni','Samburu-kwale'];
      break;
    case 'Kilifi':
      subcounties=['Chonyi','Ganze','Kaloleni','Kilifi North','Kauma','Malindi','Kilifi South','Magarini','Rabai'];
      break;
    case 'Tana River':
      subcounties=['Tana River North','Tana Delta','Tana River'];
      break;
    case 'Lamu':
      subcounties=['Lamu East','Lamu West'];
      break;
    case 'Taita Taveta':
      subcounties=['Mwatate','Taita','Taveta'];
      break;
    case 'Garissa':
      subcounties=['Balambala','Daadab','Fafi','Garissa','Hulugho','Ijara','Lagdera'];
      break;
    case 'Wajir':
      subcounties=['Buna','Eldas','Habaswein','Tarbaj','Wajir North','Wajir West','Wajir South','Wajir East'];
      break;
    case 'Mandera':
      subcounties=['Mandera West','Banisa','Kutulo','Lafey','Mandera East','Mandera Central','Mandera North'];
      break;
    case 'Marsabit':
      subcounties=['Loiyangalani','Marsabit Centra','Marsabit North','Marsabit South','Moyale','North Horr','Sololo'];
      break;
    case 'Isiolo':
      subcounties=['Garbatulla','Isiolo','Mert'];
      break;
    case 'Meru':
      subcounties=['Buuri East','Buuri West','Igembe Central','Igembe North','Igembe South','Imenti North','Imenti South','Meru Central','Tigania Central','Tigania East','Tigania West','Meru National Park','Mt. Kenya Forest'];
      break;
    case 'Tharaka Nithi':
      subcounties=['Igambang''ombe','Maara','Meru South','Tharaka North','Tharaka South','Mt. Kenya Forest'];
      break;
    case 'Embu':
      subcounties=['Embu East','Embu North','Embu West','Mbeere South','Mbeere North','Mt. Kenya Forest'];
      break;
    case 'Kitui':
      subcounties=['Ikutha','Katulani','Kisasi','Kitui Central','Kitui West','Kyuso','Lower Yatta','Matinyan','Migwani','Mumoni','Mutitu','Mutitu North','Mutomo','Mwingi Central','Mwingi East','Nzambani','Thagicu','Tseikuru'];
      break;
    case 'Machakos':
      subcounties=['Athi River','Kalama','Kangundo','Kathiani','Machakos','Masinga','Matungulu','Mwala','Yatta'];
      break;
    case 'Makueni':
      subcounties=['Kathonzweni','Kibwezi','Kilungu','Makindu','Makueni','Mbooni East','Mbooni West','Mukaa','Nzaui'];
      break;
    case 'Nyandarua':
      subcounties=['Kinangop','Nyandarua South','Mirangine','Kipipiri','Nyandarua Central','Nyandarua West','Nyandarua North','Aberdare National Park'];
      break;
    case 'Nyeri':
      subcounties=['Tetu','Kieni East','Kieni West','Mathira East','Mathira West','Nyeri South','Mukurwe-ini','Nyeri Central','Mt. Kenya Forest','Aberdare Forest'];
      break;
    case 'Muranga':
      subcounties=['Muranga East','Kangema','Mathioya','Kahuro','Muranga South','Gatanga','Kigumo','Kandara','Aberdare Forest'];
      break;
    case 'Kiambu':
      subcounties=['Gatundu North','Gatundu South','Githunguri','Juja',' Kabete','Kiambaa','Kiambu','Kikuyu','Lari','Limuru','Ruiru','Thika East','Thika West'];
      break;
    case 'Turkana':
      subcounties=['Kibish','Loima','Turkana Central','Turkana East','Turkana North','Turkana South','Turkana West'];
      break;
    case 'West Pokot':
      subcounties=['Kipkomo','Pokot Central','Pokot North','Pokot South','West Pokot'];
      break;
    case 'Samburu':
      subcounties=['Samburu Central','Samburu East','Samburu North'];
      break;
    case 'Trans Nzoia':
      subcounties=['Trans Nzoia West','Trans Nzoia East','Kwanza','Endebess','Kiminini'];
      break;
    case 'Uasin Gishu':
      subcounties=['Ainabkoi','Kapseret','Kesses','Moiben','Soy','Turbo'];
      break;
    case 'Elgeyo Marakwet':
      subcounties=['Keiyo North','Keiyo South','Marakwet East','Marakwet West'];
      break;
    case 'Nandi':
      subcounties=['Chesumei','Nandi Central','Nandi East','Nandi North','Nandi South','Tinderet'];
      break;
    case 'Baringo':
      subcounties=['Baringo Central','Baringo North','East Pokot','Koibatek','Marigat','Mogotio','Tiaty East'];
      break;
    case 'Laikipia':
      subcounties=['Laikipia Central','Laikipia East','Laikipia North','Laikipia West','Nyahururu'];
      break;
    case 'Nakuru':
      subcounties=['Gilgil','Kuresoi North','Kuresoi South','Molo','Naivasha','Nakuru East','Nakuru North','Nakuru West','Njoro','Rongai','Subukia'];
      break;
    case 'Narok':
      subcounties=['Narok East','Narok North','Narok South','Narok West','Trans Mara East','Trans Mara West','Mau Forest'];
      break;
    case 'Kajiado':
      subcounties=['Isinya','Kajiado Central','Kajiado North','Kajiado West','Loitokitok','Mashuuru'];
      break;
    case 'Kericho':
      subcounties=['Belgut','Bureti','Kericho East','Kipkelion','Londian','Soin Sigowet'];
      break;
    case 'Bomet':
      subcounties=['Bomet East','Chepalungu','Konoin','Sotik','Bomet Central'];
      break;
    case 'Kakamega':
      subcounties=['Butere','Kakamega Central','Kakamega East','Kakamega North','Kakamega South','Khwisero','Likuyani','Lugari','Matete','Matungu','Mumias East','Mumias West','Navakholo'];
      break;
    case 'Vihiga':
      subcounties=['Emuhaya','Vihiga','Sabatia','Luanda','Hamisi'];
      break;
    case 'Bungoma':
      subcounties=['Bumula','Bungoma Central','Bungoma North','Bungoma East','Bungoma South','Cheptais','Kimilili','Tongoren','Webuye'];
      break;
    case 'Busia':
      subcounties=['Bunyala','Busia','Butula','Namabale','Samia','Teso North','Teso South'];
      break;
    case 'Siaya':
      subcounties=['Siaya','Gem','Ugenya','Ugunja','Bondo','Rarieda'];
      break;
    case 'Kisumu':
      subcounties=['Kisumu East','Kisumu West','Kisumu Central','Seme','Muhoroni','Nyando','Nyakach'];
      break;
    case 'Homa Bay':
      subcounties=['Homabay','Ndhiwa','Rachuonyo East','Rachuonyo South','Rachuonyo West','Rangwe','Suba'];
      break;
    case 'Migori':
      subcounties=['Awendo','Kuria East','Kuria West','Nyatike','Rongo','Suna East','Suna West','Uriri'];
      break;
    case 'Kisii':
      subcounties=['Etago','Gucha','Gucha South','Kenyenya','Kisii Central','Kisii South','Kitutu Central','Marani','Masaba South','Nyamache','Sameta'];
      break;
    case 'Nyamira':
      subcounties=['Borabu','Manga','Masaba North','Nyamira North','Nyamira South'];
      break;
    case 'Nairobi':
      subcounties=['Dagoretti','Embakasi','Kamukunji','Kasarani','Kibra','Lang''ata','Makadara','Mathare','Njiru','Starehe','Westlands',];
      break;
  }
return subcounties;

}



}