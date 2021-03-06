import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoonEntity extends Mock
    implements PoliticalCartoonEntity {}

void main() {
  late PoliticalCartoon politicalCartoon;

  final id = '1';
  final downloadUrl = 'downloadUrl';
  final author = 'Bob';
  final description = 'A very good description';
  final tag = Tag.tag1;
  final published = Timestamp.now();
  final type = ImageType.cartoon;

  group('Political Cartoon', () {
    setUpAll(() {
      politicalCartoon = PoliticalCartoon(
        id: id,
        author: author,
        description: description,
        tags: [Tag.tag1],
        downloadUrl: downloadUrl,
        published: published,
        type: ImageType.cartoon,
      );
    });



    test(
      'conversion from political cartoon model to entity '
      'and entity to model works', () {
      final cartoon = PoliticalCartoon.fromEntity(politicalCartoon.toEntity());
      expect(cartoon, politicalCartoon);
    });

    test('fromJson method works as intended', () {
      final data = {
        'id': id,
        'timestamp': politicalCartoon.timestamp,
        'author': author,
        'description': description,
        'tags': [tag.index],
        'downloadUrl': downloadUrl,
        'published': published,
        'type': type.imageType
      };
      expect(
        PoliticalCartoonEntity.fromJson(data),
        equals(politicalCartoon.toEntity())
      );
    });
  });
}
