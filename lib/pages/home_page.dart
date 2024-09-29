import 'package:demo_app/models/person.dart';
import 'package:demo_app/repository/person_repository.dart';
import 'package:demo_app/widgets/floating_filter.dart';
import 'package:demo_app/widgets/person_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.personRepository});

  final PersonRepository personRepository;

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  late Future<List<Person>> _peopleFuture;

  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchPeople();
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

  void _fetchPeople() {
    _peopleFuture = widget.personRepository.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Person>>(
        future: _peopleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: const Color(0xFFFFF45A).withOpacity(0.5),
                padding: const EdgeInsets.all(12),
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text('No people'),
              ),
            );
          } else {
            final people = snapshot.data!;
            return SizedBox(
              child: SafeArea(
                child: Scaffold(
                  body: Padding(
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
                            itemCount: people.length,
                            itemBuilder: (_, index) =>
                                PersonCard(person: people[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
