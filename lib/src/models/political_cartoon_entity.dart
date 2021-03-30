import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/src/models/models.dart';

class PoliticalCartoonEntity extends Equatable {
  PoliticalCartoonEntity({ required this.id, required this.image, required this.author, required this.date, required this.description});
  final String id;
  final String image;
  final String date;
  final String author;
  final String description;

  @override
  List<Object?> get props => [id, image, date, author, description];

  @override
  String toString() {
    return 'PoliticalCartoonEntity { id: $id, image: $image, date: $date, author: $author, description: $description }';
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "image": this.image,
      "date": this.date,
      "author": this.author,
      "description": this.description,
    };
  }

  static PoliticalCartoonEntity fromJson(Map<String, Object> json) {
    return PoliticalCartoonEntity(
      id: json['id'] as String,
      image: json['image'] as String,
      date: json['date'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
    );
  }

  static PoliticalCartoonEntity fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data()!;
    return PoliticalCartoonEntity(
      id: snap.id,
      image: data['image'] as String,
      date: data['date'] as String,
      author: data['author'] as String,
      description: data['description'] as String,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'image': image,
      'date': date,
      'author': author,
      'description': description,
    };
  }
}