class DataModel{
  int id;
  List reviews;
  String id_number,category,title,county,
      sub_county,location,price_from,price_to,
      email,phone,description,sponsorship,created_at;
  Map<String,dynamic>image;

  DataModel({
    required this.id,
    required this.id_number,required this.category,
    required this.title,required this.county,required this.sub_county,
    required this.location,required this.price_from,required this.price_to,
    required this.email,required this.phone,required this.description,
    required this.sponsorship,required this.image,required this.reviews,required this.created_at
});

  factory DataModel.fromJson(Map<String,dynamic> json){
    return DataModel(
      id:json["id"],
      id_number: json["id_number"],
      category: json["category"],
      title: json["title"],
      county: json["county"],
      sub_county: json["sub_county"],
      location: json["location"],
      price_from: json["price_from"],
      price_to:json["price_to"],
      email: json["email"],
      phone: json["phone"],
      description: json["description"],
      sponsorship: json["sponsorship"],
      created_at:  json['created_at'],
      image:json["image"],
      reviews:json["reviews"]
    );
  }

}