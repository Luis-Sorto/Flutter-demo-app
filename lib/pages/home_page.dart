import 'package:demo_app/providers/filtered_people_provider.dart';
import 'package:demo_app/repository/person_repository.dart';
import 'package:demo_app/widgets/floating_filter.dart';
import 'package:demo_app/widgets/person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.personRepository});

  final PersonRepository personRepository;

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double currentOffset = _scrollController.offset;
    if (currentOffset > _lastOffset && _isVisible) {
      setState(() {
        _isVisible = false;
      });
    } else if (currentOffset < _lastOffset && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
    _lastOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    final filteredPeople = ref.watch(filteredPeopleProvider);

    return SizedBox(
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  FloatingFilter(isVisible: _isVisible),
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.only(
                      top: !_isVisible ? 0 : FloatingFilter.heightOffset,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      controller: _scrollController,
                      itemCount: filteredPeople.length,
                      itemBuilder: (_, index) =>
                          PersonCard(person: filteredPeople[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
