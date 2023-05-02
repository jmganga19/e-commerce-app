import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
 // static const DESCRIPTION = "description";
  static const PRICE = "price";
  static const IMAGES = "images";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const QUANTITY = "quantity";
  static const BRAND = "brand";
  static const SALE = "sale";
  static const SIZES = "sizes";
  static const COLORS = "colors";

  String? _id;
  String? _name;
  //String _description;
  int? _price;
  String? _images;
  String? _category;
  bool? _featured;
  int? _quantity;
  String? _brand;
  bool? _sale;
  List? _sizes;
  List? _colors;

  String ?get id => _id;
  String? get name => _name;
 // String get description => _description;
  int? get price => _price;
  String? get images => _images;
  String? get category => _category;
  bool? get featured => _featured;
  int? get quantity => _quantity;
  String? get brand => _brand;
  bool? get sale => _sale;
  List? get sizes => _sizes;
  List? get colors => _colors;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.get(NAME);
    _brand = snapshot.get(BRAND);
  //  _description = snapshot.get(DESCRIPTION)??" ";
    _category = snapshot.get(CATEGORY);
    _price = snapshot.get(PRICE);
    _quantity = snapshot.get(QUANTITY);
    _colors = snapshot.get(COLORS);
    _featured = snapshot.get(FEATURED);
    _sale = snapshot.get(SALE);
    _id = snapshot.get(ID);
    _images = snapshot.get(IMAGES);
    _sizes = snapshot.get(SIZES);
  }

  
}
