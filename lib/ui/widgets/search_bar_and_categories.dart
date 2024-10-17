import 'package:flutter/material.dart';

class SearchBarAndCategories extends StatefulWidget {
  const SearchBarAndCategories({super.key});

  @override
  State<SearchBarAndCategories> createState() => _SearchBarAndCategoriesState();
}

class _SearchBarAndCategoriesState extends State<SearchBarAndCategories> {
  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SearchAnchor(
          searchController: _searchController,
          builder: (context, controller) => IconButton(
            onPressed: () {
              controller.openView();
            },
            icon: const Icon(Icons.search),
          ),
          suggestionsBuilder: (context, controller) => List<ListTile>.generate(
            5,
            (index) {
              final item = 'Suggestion $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Todos'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Desarrollo web'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Programación'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Diseño'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
