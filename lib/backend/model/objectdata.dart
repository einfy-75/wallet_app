// import 'package:realm/realm.dart';

// // User model
// class User extends RealmObject {
//   @PrimaryKey()
//   int? id;

//   String? username;
//   String? email;
//   // Relationship to DebitCard model
//   final debitCards = RealmToMany<DebitCard>();

//   User({this.id, this.username, this.email});
// }

// // DebitCard model
// class DebitCard extends RealmObject {
//   @PrimaryKey()
//   int? id;

//   String? cardNumber;
//   String? cvv;
//   String? expireDate;
//   String? issueDate;

//   DebitCard({this.id, this.cardNumber, this.cvv, this.expireDate, this.issueDate});
// }
