import 'package:app_mapas/models/search_result.dart';
import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  // ignore: overridden_fields
  final String searchFieldLabel;

  SearchDestination() : searchFieldLabel = 'Buscar';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, SearchResult(cancelo: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Colocar ubicacion manualmente'),
          onTap: () {
            close(context, SearchResult(cancelo: false, manual: true));
          },
        ),
      ],
    );
  }
}
