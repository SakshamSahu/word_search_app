// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_app/presentation/provider/search_provider.dart';
import 'package:word_search_app/utils/assets.dart';

class SearchScreen extends StatefulWidget {
  final List<String> gridData;
  final int rows;
  final int columns;

  const SearchScreen({
    super.key,
    required this.gridData,
    required this.rows,
    required this.columns,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<int> _highlightedIndices = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          Assets.logoText,
          width: width * 0.6,
          fit: BoxFit.contain,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
                hintText: "Search word",
                //icon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchProvider.onSearch(
                      context,
                      _searchController,
                      widget.rows,
                      widget.columns,
                      widget.gridData,
                      (List<int> foundIndices) {
                        // Update the state with the new highlighted indices
                        setState(() {
                          _highlightedIndices = foundIndices;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.columns, childAspectRatio: 1.0),
                itemCount: widget.rows * widget.columns,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: _highlightedIndices.contains(index)
                          ? Colors.orangeAccent
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        widget.gridData[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
