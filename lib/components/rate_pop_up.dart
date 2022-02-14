import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RateService extends StatelessWidget {
  final post_id;
   RateService({Key? key,required this.post_id}):super(key:key);
  double rating = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _review = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
      RatingBar.builder(
        itemSize: 30,
      initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Constants.pamboprimaryColor,
        ),
        onRatingUpdate: (newRating) {
        rating = newRating;
          if (kDebugMode) {
            print(rating);
          }
        },
      ),
           Padding(
            padding: const EdgeInsets.only(top:10.0,bottom: 4.0),
            child:  TextField(
              controller: _review,
              maxLines: null,
                cursorColor: Constants.pamboprimaryColor,
                decoration: const InputDecoration(
                    hintText: 'Write your review',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,fontSize: 13
                    ),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Constants.pamboprimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Colors.white)
                    )
                ),
              ),
              child: const Text("RATE SERVICE",style: TextStyle(color: Constants.pamboscaffoldColor),),
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                  if(localStorage.get('user') != null){
                    // var user = jsonDecode(localStorage.getString('user')!)['last_name'];
                    // print(user);
                    print(_review.text);
                    print(rating);
                    print(post_id);

                   var response = await http.post(
                        Uri.parse(Constants.baseUrl+apiUrl),
                        headers:<String, String>{
                           'Accept':'application/json',
                           'Content-Type': 'application/json; charset=UTF-8',
                           'Authorization':'Bearer '+jsonDecode(localStorage.getString('token')!)['token'],
                           },
                     body:jsonEncode(<String,dynamic>{
                       'post_id':post_id,
                       'rating':rating,
                       // 'reviewer_last_name':user,
                       'review':_review.text
                     })
                    );

                   print(jsonDecode(response.body));
                  }else{
                    print('You need to sign up to make a review');
                  }

                }
              },
            ),
          )
        ],
      ),
    );

  }

  String apiUrl = '/add_review';
}