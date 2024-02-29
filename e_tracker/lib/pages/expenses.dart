import 'package:flutter/material.dart';

class Expense {
  final String amount;
  final String description;
  final String selectedExpense;
  final DateTime selectedDate;

  Expense({
    required this.amount,
    required this.description,
    required this.selectedExpense,
    required this.selectedDate,
  });
}

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
// After modification:
  final List<Expense> _data = [];
  String? _selectedExpense;
  DateTime? _selectedDate;

  final enabledB = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
  );
  final focusedB = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.black,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  final errorB = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text('Add Expenses'),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select the Category';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Category',
                        prefixIcon: const Icon(Icons.category),
                        enabledBorder: enabledB,
                        focusedBorder: focusedB,
                        errorBorder: errorB,
                      ),
                      value: _selectedExpense,
                      onChanged: (value) {
                        setState(() {
                          _selectedExpense = value;
                        });
                      },
                      items: <String>['Expense 1', 'Expense 2', 'Expense 3']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Amount'),
                        hintText: 'Enter the amount',
                        prefixIcon: const Icon(Icons.attach_money),
                        enabledBorder: enabledB,
                        focusedBorder: focusedB,
                        errorBorder: errorB,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Description'),
                        hintText: 'Enter a description',
                        prefixIcon: const Icon(Icons.description),
                        enabledBorder: enabledB,
                        focusedBorder: focusedB,
                        errorBorder: errorB,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                        Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        ),
                        const Text(
                          ' *', // Required indicator
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Only proceed if the form is valid
                          setState(() {
                            _data.add(Expense(
                              amount: _amountController.text,
                              description: _descriptionController.text,
                              selectedExpense: _selectedExpense!,
                              selectedDate: _selectedDate!,
                            ));
                          });
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Expense Type')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Action')),
                ],
                rows: _data.take(5).map((expense) {
                  final index = _data.indexOf(expense);
                  return DataRow(cells: [
                    DataCell(Text(
                        '${expense.selectedDate.day}-${expense.selectedDate.month}-${expense.selectedDate.year}')),
                    DataCell(Text(expense.amount)),
                    DataCell(Text(expense.selectedExpense)),
                    DataCell(Text(expense.description)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _data.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Expenses(),
  ));
}
