import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _todo = TextEditingController();
  final List<String> _todos = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do-list",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("To-do-list"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todo,
                      decoration:
                          const InputDecoration(labelText: "Enter task"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _todos.add(_todo.text);
                        _todo.clear();
                      });
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_todos[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min, // Keep the row compact
                        children: [
                          IconButton(
                            // Your existing delete button
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _todos.removeAt(index);
                              });
                            },
                          ),
                          IconButton(
                            // Your new edit button
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              final taskToEdit =
                                  _todos[index]; // Get the original task
                              final editingController = TextEditingController(
                                  text:
                                      taskToEdit); // Controller for dialog's text field

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Edit Task"),
                                      content: TextFormField(
                                        controller:
                                            editingController, // Associate the controller
                                        initialValue: taskToEdit,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              final editedTask =
                                                  editingController.text;
                                              setState(() {
                                                _todos[index] = editedTask;
                                                Navigator.pop(
                                                    context); // Close dialog
                                              });
                                            },
                                            child: const Text("Save")),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
