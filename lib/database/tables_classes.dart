class user{
  int? id;
  String? name;
  String? mail;
  String? pass;
  user({this.id , this.name , this.mail , this.pass});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'pass': pass,
    };
  }


  String toString() {
    return 'user{id: $id , name: $name , mail: $mail , pass: $pass}';
  }

}

class product{
  int? id;
  int typeID;
  String name;
  String desc;
  int price;
  String image;
  product({required this.id ,required this.typeID ,required this.name ,required this.desc ,required this.price ,required this.image});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typeID': typeID,
      'name': name,
      'desc': desc,
      'price': price,
      'image': image,
    };
  }


  String toString() {
    return 'product{id: $id , typeID: $typeID , name: $name , desc: $desc , price: $price , image: $image}';
  }

}


class type{
  int? id;
  String? name;
  type({this.id , this.name});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,

    };
  }


  String toString() {
    return 'type{id: $id ,name: $name}';
  }

}


class cart{
  int? userID;
  int? productID;
  cart({this.userID , this.productID});


  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'productID': productID,
    };
  }


  String toString() {
    return 'cart{userID: $userID ,productID: $productID}';
  }

}