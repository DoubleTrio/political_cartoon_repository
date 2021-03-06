import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';
import 'package:political_cartoon_repository/src/firestore/utils/utils.dart';

class PoliticalCartoonEntity extends Equatable {
  PoliticalCartoonEntity({
    required this.id,
    required this.author,
    required this.timestamp,
    required this.description,
    required this.tags,
    required this.downloadUrl,
    required this.published,
    required this.type
  });

  final String id;
  final Timestamp timestamp;
  final String author;
  final String description;
  final List<Tag> tags;
  final String downloadUrl;
  final Timestamp published;
  final ImageType type;

  @override
  List<Object?> get props =>
      [id, timestamp, author, description, tags, downloadUrl, published, type];

  @override
  String toString() {
    return 'PoliticalCartoonEntity { '
      'id: $id, '
      'timestamp: $timestamp, '
      'author: $author, '
      'description: $description, '
      'tags: $tags, '
      'downLoadUrl: $downloadUrl, '
      'published: $published '
      'type: $type'
    '}';
  }

  static PoliticalCartoonEntity fromJson(Map<String, Object> json) {
    return PoliticalCartoonEntity(
      id: json['id'] as String,
      timestamp: json['timestamp'] as Timestamp,
      author: json['author'] as String,
      description: json['description'] as String,
      tags: mapTagIdToTags(json['tags'] as List<int>),
      downloadUrl: json['downloadUrl'] as String,
      published: json['published'] as Timestamp,
      type: ImageTypeExtension.fromString(json['type'] as String)
    );
  }

  static PoliticalCartoonEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data()!;
    return PoliticalCartoonEntity(
      id: snap.id,
      timestamp: data['timestamp'] as Timestamp,
      author: data['author'] as String,
      description: data['description'] as String,
      tags: mapTagIdToTags(List<int>.from(data['tags'] as Iterable<dynamic>)),
      downloadUrl: data['downloadUrl'] as String,
      published: data['published'] as Timestamp,
      type: ImageTypeExtension.fromString(data['type'] as String),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'timestamp': timestamp,
      'author': author,
      'description': description,
      'tags': mapTagsToTagIds(tags),
      'downloadUrl': downloadUrl,
      'published': published,
      'type': type.docType,
    };
  }
}
