import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:new_pambo/constants/constant.dart';

class RateService extends StatefulWidget {
  const RateService({Key? key}) : super(key: key);

  @override
  _RateServiceState createState() => _RateServiceState();
}

class _RateServiceState extends State<RateService> {
  double rating = 0;
  final _formKey = GlobalKey<FormState>();

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
          const Padding(
            padding: EdgeInsets.only(top:10.0,bottom: 4.0),
            child:  TextField(
              maxLines: null,
                cursorColor: Constants.pamboprimaryColor,
                decoration: InputDecoration(
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
            ),
          )
        ],
      ),
    );

  }
}