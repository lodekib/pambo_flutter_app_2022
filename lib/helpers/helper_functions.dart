import 'dart:math';

class Helper{
  double dp(double val, int places){
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  double reviews(reviews){
    double sum = 0;
    for(int i = 0;i<reviews.length; i++){
      sum+=double.parse(reviews[1]['rating']);
    }
    return sum/reviews.length;
  }
}