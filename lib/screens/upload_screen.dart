import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController price_from = TextEditingController();
  TextEditingController price_to = TextEditingController();
  TextEditingController description = TextEditingController();
  var sponsorship;
  bool isChecked = false;
  String selectedCategoryValue = Constants.categories[0];
  var  currentSelectedCounty;
  var  currentSelectedsubcounty;
  List<String> sub_counties=[];
  Constants constants = Constants();
  List<ImageObject> _imgObjs = [];
  bool hasImages = false;
  final _formKey = GlobalKey<FormState>();

  List<File> imageFiles = [];
  List resultList = [];


  @override
  Widget build(BuildContext context) {
    List<String> counties = constants.counties;
    final configs = ImagePickerConfigs();
    configs.appBarBackgroundColor=Constants.pamboprimaryColor;
    configs.iconClose = Icons.close_outlined;
    configs.translateFunc = (name, value) => Intl.message(value, name: name);
    return  Scaffold(
      floatingActionButton:!isChecked ? FloatingActionButton.extended(
        backgroundColor: Constants.pamboprimaryColor,
        onPressed: () async {
          final List<ImageObject>? objects = await Navigator.of(context)
              .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
            return const ImagePicker(maxCount: 5);
          }));

          if ((objects?.length ?? 0) > 0) {
            for(int i=0; i<objects!.length; i++){
              imageFiles.add(File(objects[i].modifiedPath));
            };
            setState(() {
              _imgObjs = objects;
              hasImages = true;
            });
          }
        },
        label: const Text('Choose image(s)'),
        icon: const Icon(Icons.camera),
      ):Container(),
       appBar: AppBar(
         elevation: 0,
         leading: Row(
           children: <Widget>[
             GestureDetector(
               onTap:(){
                 Navigator.pop(context);
                 },
               child: Container(
                 padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                 child: const Icon(Icons.keyboard_arrow_left, color: Constants.pamboscaffoldColor,size: 30,),
               ),
             ),
           ],
         ),
         backgroundColor: Constants.pamboprimaryColor,
         title:const Text('Upload Service'),
         centerTitle: true,
       ),
       body:   SingleChildScrollView(
         child: Form(
           key: _formKey,
           child: Padding(
             padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
             child: Column(
               children: [
                 Container(
                   child: hasImages ? Container(
                     height: 80,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                         shrinkWrap: true,
                         itemCount: _imgObjs.length,
                         itemBuilder: (BuildContext context, int index) {
                           final image = _imgObjs[index];
                           return Image.file(File(image.modifiedPath), fit: BoxFit.cover);
                         }),
                   ) : const Text('NEW SERVICE',style: TextStyle(fontWeight: FontWeight.bold),),
                 ),

                // CATEGORY
                 Padding(
                   padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                   child: Row(
                     children: const [
                       Text('Service Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                     ],
                   ),
                 ),
                 Container(
                     width: double.infinity,
                     decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                         border: Border.all(color: Constants.pamboprimaryColor, width: 0.4)),
                     padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                     child: DropdownButtonHideUnderline(
                       child: ButtonTheme(
                         alignedDropdown: true,
                         child: DropdownButton(
                           isExpanded: true,
                           isDense: true,
                           value: selectedCategoryValue,
                           icon: const Icon(
                             Icons.keyboard_arrow_down,
                             color: Constants.pamboprimaryColor,
                           ),
                           iconSize: 30,
                           underline: Container(
                             height: 1,
                             color: Colors.transparent,
                           ),
                           onChanged: (val) {
                               setState(() {
                                 selectedCategoryValue = val as String;
                               });
                                 },
                           items: Constants.categories.map((option) {
                             return DropdownMenuItem(
                               value: option,
                               child: Text(option),
                             );
                           }).toList(),
                         ),
                       ),
                     )
                 ),

                 //COUNTY


                 Padding(
                   padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                   child: Row(
                     children: const [
                       Text('County',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                     ],
                   ),
                 ),
                     Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                        Radius.circular(10.0)),
                        border: Border.all(
                        color: Constants.pamboprimaryColor, width: 0.4)),
                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                        isExpanded: true,
                        isDense: true,
                        value:currentSelectedCounty,
                        icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Constants.pamboprimaryColor,
                        ),
                        iconSize: 30,
                        underline: Container(
                        height: 1,
                        color: Colors.transparent,
                        ),
                        onChanged:(String? new_county) {
                        setState(() {
                          currentSelectedsubcounty = null;
                        currentSelectedCounty=new_county!;
                        sub_counties = constants.getSubCounty(new_county);
                        });
                        },
                        items: counties.map<DropdownMenuItem<String>>((option) {
                        return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                        );
                        }).toList(),
                        ),
                        ),
                        )
                        ),


               //  SUBCOUNTY
                 Padding(
                   padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                   child: Row(
                     children: const [
                       Text('Sub County',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                     ],
                   ),
                 ),

                Container(
                             width: double.infinity,
                             decoration: BoxDecoration(
                                 borderRadius: const BorderRadius.all(
                                     Radius.circular(10.0)),
                                 border: Border.all(
                                     color: Constants.pamboprimaryColor, width: 0.4)),
                             padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                             child: DropdownButtonHideUnderline(
                               child: ButtonTheme(
                                 alignedDropdown: true,
                                 child: DropdownButton<String>(
                                   isExpanded: true,
                                   isDense: true,
                                   value:currentSelectedsubcounty,
                                   icon: const Icon(
                                     Icons.keyboard_arrow_down,
                                     color: Constants.pamboprimaryColor,
                                   ),
                                   iconSize: 30,
                                   underline: Container(
                                     height: 1,
                                     color: Colors.transparent,
                                   ),
                                   onChanged: (String? val) {
                                     setState(() {
                                        currentSelectedsubcounty = val!;
                                     });
                                   },
                                   items:sub_counties.map<DropdownMenuItem<String>>((String sub_county) {
                                     return DropdownMenuItem<String>(
                                       value: sub_county,
                                       child: Text(sub_county),
                                     );
                                   }).toList(),
                                 ),
                               ),
                             )
                     ),

                 Container(
               margin: const EdgeInsets.symmetric(vertical: 10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:  <Widget>[
                  const Text(
                     "Service Title",
                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                   ),
                   const SizedBox(
                     height: 10,
                   ),
                   TextField(
                     controller: title,
                       cursorColor: Constants.pamboprimaryColor,
                       decoration: const InputDecoration(
                           hintText: 'Brief title  of the service ',
                           hintStyle: TextStyle(
                               color:Colors.grey,
                               fontWeight: FontWeight.w300,
                               fontSize: 13
                           ),
                           border: InputBorder.none,
                           fillColor: Color(0xfff3f3f4),
                           filled: true
                       ))
                 ],
               ),
             ),
                 Container(
                   margin: const EdgeInsets.symmetric(vertical: 10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:  <Widget>[
                      const Text(
                         "Service Location",
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       TextField(
                         controller: location,
                         keyboardType: TextInputType.streetAddress,
                           cursorColor: Constants.pamboprimaryColor,
                           decoration: const InputDecoration(
                             hintText: 'Specific street of your service eg street,Rd ',
                               hintStyle: TextStyle(
                                 color:Colors.grey,
                                 fontWeight: FontWeight.w300,
                                 fontSize: 13
                               ),
                               border: InputBorder.none,
                               fillColor: Color(0xfff3f3f4),
                               filled: true
                           ))
                     ],
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(
                       flex:1,
                       child: Padding(
                         padding: const EdgeInsets.only(right: 8.0),
                         child: Container(
                           margin: const EdgeInsets.symmetric(vertical: 10),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:  <Widget>[
                               const Text(
                                 "Price From (KSH)",
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                               ),
                             const  SizedBox(
                                 height: 10,
                               ),
                               TextField(
                                 controller: price_from,
                                 keyboardType: TextInputType.number,
                                   cursorColor: Constants.pamboprimaryColor,
                                   decoration: const InputDecoration(
                                       hintText: 'Lowest price range',
                                       hintStyle: TextStyle(
                                           color:Colors.grey,
                                           fontWeight: FontWeight.w300,
                                           fontSize: 13
                                       ),
                                       border: InputBorder.none,
                                       fillColor: Color(0xfff3f3f4),
                                       filled: true
                                   ))
                             ],
                           ),
                         ),
                       ),
                     ),
                     Expanded(
                       flex:1,
                       child: Padding(
                         padding: const EdgeInsets.only(left:8.0),
                         child: Container(
                           margin: const EdgeInsets.symmetric(vertical: 10),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:  <Widget>[
                               const Text(
                                 "Price To (KSH)",
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               TextField(
                                 controller:price_to,
                                 keyboardType: TextInputType.number,
                                   cursorColor: Constants.pamboprimaryColor,
                                   decoration: const InputDecoration(
                                       hintText: 'Highest price range',
                                       hintStyle: TextStyle(
                                           color:Colors.grey,
                                           fontWeight: FontWeight.w300,
                                           fontSize: 13
                                       ),
                                       border: InputBorder.none,
                                       fillColor: Color(0xfff3f3f4),
                                       filled: true
                                   ))
                             ],
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
                 Container(
                   margin: const EdgeInsets.symmetric(vertical: 10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:  <Widget>[
                       const Text(
                         "Service Description",
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                       ),
                      const  SizedBox(
                         height: 10,
                       ),
                       TextField(
                         controller:description,
                         maxLines: null,
                           keyboardType: TextInputType.streetAddress,
                           cursorColor: Constants.pamboprimaryColor,
                           decoration: const InputDecoration(
                               hintText: 'Detailed description of the service',
                               hintStyle: TextStyle(
                                   color:Colors.grey,
                                   fontWeight: FontWeight.w300,
                                   fontSize: 13
                               ),
                               border: InputBorder.none,
                               fillColor: Color(0xfff3f3f4),
                               filled: true
                           ))
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                   child: Row(children: const [Text('Service Promotion Fee',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)],),
                 ),
                 CustomRadioButton(
                   enableShape: true,
                   height: 50,
                   elevation: 0,
                   unSelectedBorderColor: Constants.pamboscaffoldColor,
                   selectedBorderColor: Constants.pamboscaffoldColor,
                   absoluteZeroSpacing: true,
                   unSelectedColor: Theme.of(context).canvasColor,
                   buttonLables: const ['Free','Silver','Platinum'],
                   buttonValues: const ["0","100","200"],
                   buttonTextStyle: const ButtonTextStyle(
                       selectedColor: Colors.white,
                       unSelectedColor: Colors.black,
                       textStyle: TextStyle(fontSize: 13)),
                   radioButtonValue: (value) {
                     print(value);
                     sponsorship = value;
                   },
                   selectedColor:Constants.pamboprimaryColor
                 ),
            Row(
              children: [
                Checkbox(
                     checkColor: Colors.white,
                     fillColor: MaterialStateProperty.all(Constants.pamboprimaryColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        if (kDebugMode) {
                          print(value);
                        }
                      });
                    },
                  ),
               const SizedBox(width:2,),
                const Text('Please agree to ',),
                const Text('terms and conditions.',style: TextStyle(color: Color(0xfff79c4f),fontWeight: FontWeight.bold),)
              ],
            ),
              isChecked ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: ()async{
                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                  var token=jsonDecode(localStorage.getString('token')!)['token'];
                  if(token != null){
                    List <http.MultipartFile> multiparts =  <http.MultipartFile>[];
                    http.MultipartRequest request = http.MultipartRequest('POST',Uri.parse(Constants.baseUrl+'/post'));
                    var headers= <String, String>{
                      'Accept':'application/json',
                          'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':'Bearer '+token,
                      };

                    for(int i=0; i< imageFiles.length; i++){
                      String filename=imageFiles[i].path.split("/").last;
                      var stream=  http.ByteStream(DelegatingStream.typed(imageFiles[i].openRead()));
                      var length=await imageFiles[i].length();
                      var multipartFile= http.MultipartFile("images[]", stream, length,filename:filename);
                      multiparts.add(multipartFile);
                    }
                    request.headers.addAll(headers);
                    request.files.addAll(multiparts);
                    print(multiparts);
                    request.fields['category']=selectedCategoryValue;
                    request.fields['county']=currentSelectedCounty;
                    request.fields['sub_county']=currentSelectedsubcounty;
                    request.fields['title']=title.text;
                    request.fields['location']=location.text;
                    request.fields['price_from']=price_from.text;
                    request.fields['price_to']=price_to.text;
                    request.fields['description']=description.text;
                    request.fields['sponsorship']=sponsorship;

                    print(request.fields);
                    var response = await request.send();
                    var respString = json.decode(await response.stream.bytesToString());
                   if(respString['status']){
                     print(respString['message']);
                   }else{
                     print('Unable to Upload the post');
                   }

                  }

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFDB228E),
                            Color(0xFFDB228E)])),
                  child: const Text(
                    'UPLOAD SERVICE',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ) :Container()
             ]
           )),
         ),
       )
    );
  }



}



