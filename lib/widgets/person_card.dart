import 'package:demo_app/models/person.dart';
import 'package:demo_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    Widget photoSectionBuilder() {
      return Padding(
        padding: const EdgeInsets.only(
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(bottom: 8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Image.network(
                '${person.photoUrl}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 60,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                person.titleProfession ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      );
    }

    Widget descriptionItemsBuilder() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardEntry(
            entryType: CardEntryEnum.name,
            value: '${person.name??'N/A'} ${person.lastName??''}',
            showDivider: false,
            margin: const EdgeInsets.only(bottom: 20),
          ),
          _CardEntry(entryType: CardEntryEnum.birthday, value: person.birthday),
          _CardEntry(entryType: CardEntryEnum.state, value: person.state),
          _CardEntry(
            entryType: CardEntryEnum.zipCode,
            value: person.zip,
            margin: const EdgeInsets.only(bottom: 18),
          ),
          _CardEntry(
            entryType: CardEntryEnum.quote,
            value: person.quote,
            showDivider: false,
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          photoSectionBuilder(),
          descriptionItemsBuilder(),
        ],
      ),
    );
  }
}

enum CardEntryEnum {
  name(),
  birthday(label: 'Birthday', icon: Icons.cake),
  state(label: 'State', icon: Icons.location_on),
  zipCode(label: 'Zip Code', icon: Icons.numbers),
  quote();

  const CardEntryEnum({this.label = '', this.icon});

  final String? label;
  final IconData? icon;
}

class _CardEntry extends StatelessWidget {
  const _CardEntry({
    this.value,
    required this.entryType,
    this.showDivider = true,
    this.margin = const EdgeInsets.only(bottom: 12),
  });

  final CardEntryEnum entryType;
  final String? value;
  final bool showDivider;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final isDate = entryType == CardEntryEnum.birthday;
    final isQuote = entryType == CardEntryEnum.quote;
    final isDefault = !(entryType == CardEntryEnum.name || isQuote);

    final displayValue = value?? 'N/A';

    final text = '${entryType.label}'
    '${isDefault ? ": " : ''}'
    '${isQuote ? '"$displayValue"' : (isDate && value!=null)
        ? DateFormatter.monthDateYear.format(DateTime.parse(value!))
        : displayValue}';

    final fontSyle = switch (entryType) {
      CardEntryEnum.name => const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      CardEntryEnum.quote => TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.blueGrey[700],
          height: 1,
        ),
      CardEntryEnum.birthday => TextStyle(
          fontSize: 14.0,
          color: Colors.grey[600],
          height: 1,
        ),
      CardEntryEnum.state => TextStyle(
          fontSize: 14.0,
          color: Colors.grey[600],
          height: 1,
        ),
      CardEntryEnum.zipCode => TextStyle(
          fontSize: 14.0,
          color: Colors.grey[600],
          height: 1,
        ),
    };

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDefault)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    entryType.icon,
                    size: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              SizedBox(
                width: 155,
                child: Text(
                  text,
                  style: fontSyle,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  textAlign: isQuote ? TextAlign.center : null,
                ),
              ),
            ],
          ),
          if (showDivider) const _CardEntryDivider()
        ],
      ),
    );
  }
}

class _CardEntryDivider extends StatelessWidget {
  const _CardEntryDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.grey[600],
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 6),
      height: 1.5,
      width: 180,
    );
  }
}
