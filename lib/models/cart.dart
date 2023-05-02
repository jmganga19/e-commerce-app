
class CartItemModel {
  static const ID = 'id';
  static const PNAME = 'name';
  static const IPRODUCT = 'images';
  static const PRICE = 'price';
  static const PRODUCTID = 'productId';
  static const SIZE = 'size';

  //static const QUANTITY = 'quantity';

   static const COLOR = 'color';


  String? _id;
  String? _productName;
  String? _productImage;
  String? _productId;
  String? _size;
  String? _color;
  int? _price;
  //String? _quantity;

  //getters
  String? get name => _productName;
  String? get picture => _productImage;
  String? get id => _id;
  int? get price => _price;
  String? get size => _size;
  String? get color => _color;
  String ? get productId => _productId;
  //String? get quantity => _quantity;


  CartItemModel.fromMap(Map data) {
    _productName = data[PNAME];
    _price = data[PRICE];
    _id = data[ID];
    _productImage = data[IPRODUCT];
    _size = data[SIZE];
     _color = data[COLOR];
    _productId = data[PRODUCTID];
  //  _quantity = data[QUANTITY];

  }
  Map toMap() => {
        ID: _id,
        PNAME: _productName,
        IPRODUCT: _productImage,
        PRICE: _price,
        SIZE: _size,
         COLOR: _color,
        PRODUCTID:_productId,
       // QUANTITY: _quantity

      };
}
