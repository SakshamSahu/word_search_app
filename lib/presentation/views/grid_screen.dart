// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_search_app/presentation/views/search_screen.dart';
import 'package:word_search_app/utils/assets.dart';
import 'package:word_search_app/utils/widgets/custom_button.dart';

class GridScreen extends StatefulWidget {
  static String routeName = "grid_screen";
  final int rows;
  final int columns;
  const GridScreen({
    super.key,
    required this.rows,
    required this.columns,
  });

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  late List<TextEditingController>
      textControllers; // Controllers for each grid cell
  late List<FocusNode> focusNodes; // Focus nodes for each grid cell

  @override
  void initState() {
    super.initState();
    // Initialize the controllers, one for each grid cell
    textControllers = List.generate(
      widget.rows * widget.columns,
      (index) => TextEditingController(),
    );
    focusNodes = List.generate(
      widget.rows * widget.columns,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.columns, childAspectRatio: 1.0),
                    itemCount: widget.columns * widget.rows,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          controller: textControllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10)),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                          textCapitalization: TextCapitalization.characters,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // Move to the next focus if the input is not empty
                              if (index < textControllers.length - 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            }
                          },
                        ),
                      );
                    }),
              ),
              CustomButton(
                text: "Submit",
                onPressed: () {
                  final List<String> gridData = [];

                  for (int i = 0; i < widget.rows * widget.columns; i++) {
                    final cellText = textControllers[i]
                        .text
                        .toUpperCase(); // Retrieve and convert to uppercase
                    gridData.add(cellText);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                          gridData: gridData,
                          rows: widget.rows,
                          columns: widget.columns),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
