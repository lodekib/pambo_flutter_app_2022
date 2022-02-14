class Helper{
  double reviews(reviews){
    double sum = 0;
    for(int i = 0;i<reviews.length; i++){
      sum+=double.parse(reviews[1]['rating']);
    }
    return sum/reviews.length;
  }
}