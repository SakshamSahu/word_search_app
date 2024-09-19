import 'package:flutter/material.dart';
import 'package:word_search_app/presentation/views/grid_screen.dart';
import 'package:word_search_app/utils/assets.dart';
import 'package:word_search_app/utils/widgets/custom_button.dart';
import 'package:word_search_app/utils/widgets/custom_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _columnController = TextEditingController();
  // Global key to validate the form
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.1),
              Image.asset(
                Assets.logo,
                width: width * 0.4,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.02),
              Image.asset(
                Assets.logoText,
                width: width * 0.6,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.04),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rows",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: height * 0.006),
              TextFormField(
                validator: (value) {
                  int? rows = int.tryParse(value ?? "");
                  if (rows == null || rows < 3) {
                    customSnackBar(
                        context, "Please enter a valid number (min 3)", true);
                  }
                  return null;
                },
                controller: _rowController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.orangeAccent,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: "Enter Number of Rows"),
              ),
              SizedBox(height: height * 0.02),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Columns",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: height * 0.006),
              TextFormField(
                validator: (value) {
                  int? columns = int.tryParse(value ?? "");
                  if (columns == null || columns < 3) {
                    customSnackBar(
                        context, "Please enter a valid number (min 3)", true);
                  }
                  return null;
                },
                controller: _columnController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.orangeAccent,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: "Enter Number of Columns"),
              ),
              SizedBox(height: height * 0.02),
              CustomButton(
                  text: "Create Grid",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      int rows = int.parse(_rowController.text);
                      int columns = int.parse(_columnController.text);
                      if (rows < 3 || columns < 3) {
                        customSnackBar(
                            context,
                            "Please enter row or column value greater than 3",
                            true);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GridScreen(rows: rows, columns: columns)));
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
