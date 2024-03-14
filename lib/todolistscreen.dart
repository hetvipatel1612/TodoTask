import 'package:flutter/material.dart';
import 'package:todoproject/viewmodel/todoviewmodel.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
@override
  void initState() {
    super.initState();
     Provider.of<TodoViewModel>(context, listen: false).fetchTodos();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<TodoViewModel>(
                builder: (context, viewModel, _) => ListView.builder(
                  itemCount: viewModel.todos.length,
                  itemBuilder: (context, index) {
                    final todo = viewModel.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (newValue) {
                          viewModel.toggleTodoCompletion(todo.id, newValue!);
                        },
                      ),
                      trailing: 
                          Row(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                 _updateTodoDialog(context,todo.id,todo.title);
                                },
                       
                      ), IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  viewModel.deleteTodo(todo.id);
                                
                                },
                       
                      ),
                            ],
                          ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                _addTodoDialog(context);
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  void _updateTodoDialog(BuildContext context, String id, String title) {
    final TextEditingController controller = TextEditingController();
controller.text=title;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Provider.of<TodoViewModel>(context, listen: false)
                      .updateTodo(id,controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _addTodoDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Provider.of<TodoViewModel>(context, listen: false)
                      .addTodo(controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
