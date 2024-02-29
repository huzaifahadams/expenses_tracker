import 'package:flutter/material.dart';

//my class
class Category {
  final String cattype;

  Category({
    required this.cattype,
  });
}

class ExpensesCategory extends StatefulWidget {
  const ExpensesCategory({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExpensesCategoryState createState() => _ExpensesCategoryState();
}

class _ExpensesCategoryState extends State<ExpensesCategory> {
  final TextEditingController _typeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //using my created category
  final List<Category> _categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text('Add Expenses Categories'),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              maxLength: 15,
              controller: _typeController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Category';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text('Name'),
                hintText: 'Enter your name',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Only proceed if the form is valid
                setState(() {
                  if (_categories.length < 5) {
                    _categories.add(Category(
                      cattype: _typeController.text,
                    ));
                    _typeController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Category limit reached (5)'),
                      ),
                    );
                  }
                });
              }
            },
            child: const Text('Add'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Category Name')),
                    DataColumn(label: Text('Action ')),
                  ],
                  rows: _categories.map((c) {
                    final index = _categories.indexOf(c);
                    return DataRow(cells: [
                      DataCell(Text(c.cattype)),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _categories.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ]);
                  }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ExpensesCategory(),
  ));
}
