import 'package:cloud_firestore/cloud_firestore.dart';

class InfoDataModel {
  late String? description;
  late String? infoDataId;
  late Timestamp? dateCreated;
  //String category;
  late double? value;

  InfoDataModel(
      {this.description, this.infoDataId, this.dateCreated, this.value});

  InfoDataModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    infoDataId = documentSnapshot!.id;
    description = documentSnapshot["description"];
    dateCreated = documentSnapshot["dateCreated"];
    //category = documentSnapshot.data["category"];
    value = documentSnapshot["value"];
  }
}
