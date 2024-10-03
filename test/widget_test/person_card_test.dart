import 'package:demo_app/models/person.dart';
import 'package:demo_app/widgets/person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUp(() {
    // Clear any previous image caches before running each test
    imageCache.clear();
  });

  tearDown(() {
    // Clean up after each test if needed
    imageCache.clear();
  });

  group('Person card tests', () {
    testWidgets('Person failed image', (tester) async {
      imageCache.clear();

      final person = Person(
        name: 'Luis',
        lastName: 'Sorto',
        birthday: '1995-10-06',
        gender: 'Male',
        quote: 'Hapiness is only real when shared',
        photoUrl: 'badurl',
        titleProfession: 'Programmer',
        state: 'San Salvador',
        zip: '111111',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PersonCard(person: person),
          ),
        ),
      );

      await tester.pumpAndSettle(Durations.short4);

      expect(find.byIcon(Icons.person_rounded), findsOneWidget);
    });
    testWidgets('Successfull Person card', (tester) async {
      final person = Person(
        name: 'Luis',
        lastName: 'Sorto',
        birthday: '1995-10-06',
        gender: 'Male',
        quote: 'Hapiness is only real when shared',
        photoUrl: 'https://randomuser.me/api/portraits/men/0.jpg',
        titleProfession: 'Programmer',
        state: 'San Salvador',
        zip: '111111',
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PersonCard(person: person),
            ),
          ),
        );
      });

      await tester.pumpAndSettle();

      expect(find.text('Programmer'), findsOneWidget);
      expect(find.text('Luis Sorto'), findsOneWidget);
      expect(find.text('Birthday: Oct 6, 1995'), findsOneWidget);
      expect(find.text('State: San Salvador'), findsOneWidget);
      expect(find.text('Zip Code: 111111'), findsOneWidget);
      expect(find.text('"Hapiness is only real when shared"'), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);

      final imageWidget = tester.widget<Image>(find.byType(Image));
      expect((imageWidget.image as NetworkImage).url,
          equals('https://randomuser.me/api/portraits/men/0.jpg'));
    });

    testWidgets('Empty person card', (tester) async {
      final person = Person(
        photoUrl: 'https://randomuser.me/api/portraits/men/0.jpg',
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PersonCard(person: person),
            ),
          ),
        );
      });

      await tester.pumpAndSettle();

      expect(find.text('Birthday: N/A'), findsOneWidget);
      expect(find.text('State: N/A'), findsOneWidget);
      expect(find.text('Zip Code: N/A'), findsOneWidget);
      expect(find.text('"N/A"'), findsOneWidget);
      expect(find.text('N/A '), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });
  });
}
