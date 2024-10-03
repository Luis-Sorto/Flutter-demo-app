import 'package:demo_app/models/person.dart';
import 'package:test/test.dart';

void main() {
  group('Parse model person', () {
    test('Parse from json', () {
      final personJson = {
        'name': 'Richard',
        'last_name': 'Jacobson',
        'birthday': '2005-12-07',
        'gender': 'male',
        'state': 'Illinois',
        'zip': '45461',
        'photo_url': 'https://randomuser.me/api/portraits/men/74.jpg',
        'title_profession': 'Charity officer',
        'quote': 'Early take star possible get.',
      };

      final person = Person.fromJson(personJson);

      expect(person.name, 'Richard');
      expect(person.lastName, 'Jacobson');
      expect(person.birthday, '2005-12-07');
      expect(person.gender, 'male');
      expect(person.state, 'Illinois');
      expect(person.zip, '45461');
      expect(person.photoUrl, 'https://randomuser.me/api/portraits/men/74.jpg');
      expect(person.quote, 'Early take star possible get.');
    });

    test('Parse from json with null fields', () {
      final personJson = {
        'name': null,
        'last_name': null,
        'birthday': null,
        'gender': null,
        'state': null,
        'zip': null,
        'photo_url': null,
        'title_profession': null,
        'quote': null,
      };

      final person = Person.fromJson(personJson);

      expect(person.name, isNull);
      expect(person.lastName, isNull);
      expect(person.birthday, isNull);
      expect(person.gender, isNull);
      expect(person.state, isNull);
      expect(person.zip, isNull);
      expect(person.photoUrl, isNull);
      expect(person.titleProfession, isNull);
      expect(person.quote, isNull);
    });

    test('Convert to json', () {
      final person = Person(
        id: 1,
        name: 'Richard',
        lastName: 'Jacobson',
        birthday: '2005-12-07',
        gender: 'male',
        state: 'Illinois',
        zip: '45461',
        photoUrl: 'https://randomuser.me/api/portraits/men/74.jpg',
        titleProfession: 'Charity officer',
        quote: 'Early take star possible get.',
      );

      final personJson = person.toJson();

      expect(personJson['id'], 1);
      expect(personJson['name'], 'Richard');
      expect(personJson['last_name'], 'Jacobson');
      expect(personJson['birthday'], '2005-12-07');
      expect(personJson['gender'], 'male');
      expect(personJson['state'], 'Illinois');
      expect(personJson['zip'], '45461');
      expect(personJson['photo_url'],
          'https://randomuser.me/api/portraits/men/74.jpg');
      expect(personJson['title_profession'], 'Charity officer');
      expect(personJson['quote'], 'Early take star possible get.');
    });

    test('Convert to json with null fields', () {
      final person = Person();

      final personJson = person.toJson();

      expect(personJson['id'], isNull);
      expect(personJson['name'], isNull);
      expect(personJson['last_name'], isNull);
      expect(personJson['birthday'], isNull);
      expect(personJson['gender'], isNull);
      expect(personJson['state'], isNull);
      expect(personJson['zip'], isNull);
      expect(personJson['photo_url'], isNull);
      expect(personJson['title_profession'], isNull);
      expect(personJson['quote'], isNull);
    });
  });
}
